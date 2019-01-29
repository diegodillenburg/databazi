class RepositoryPodio
  @@is_podio_initialized = false

  class << self
    def create_ep(application, params)
      check_podio
      Podio::Item.create(application, fields: params)
    end

    def delete_ep(id)
      check_podio
      Podio::Item.delete(id)
    end

    def change_status(id, application)
      check_podio
      attrs = {'fields': {
        'status-expa': map_status(application.exchange_participant.status.to_sym),
        'teste-di-data-do-applied': parse_date(application.applied_at),
        'teste-di-data-do-accepted': parse_date(application.accepted_at),
        'teste-di-data-do-approved': parse_date(application.approved_at),
        'teste-di-data-do-break-approval': parse_date(application.break_approved_at)
      }}
      item = Podio::Item.update(id, attrs)
      item
    end

    def get_item(id)
      check_podio
      Podio::Item.find(id)
    end

    # TODO: Code the Podio ICX application integration
    def save_icx_application(application)
      check_podio

      sync_icx_country(application)
      # rubocop:disable Metrics/LineLength
      params = {
        title: application.exchange_participant.fullname,
        'ep-id': application.expa_ep_id,
        status: status_to_podio(application.status),
        email: [
          {
            'type': 'home',
            value: application.exchange_participant.email
          }
        ],
        'data-de-nascimento': parse_date(application.exchange_participant.birthdate),
        'data-do-applied': parse_date(application.applied_at),
        'data-do-accepted': parse_date(application.accepted_at),
        'data-do-approved': parse_date(application.approved_at),
        'data-do-break-approval': parse_date(application.break_approved_at),
        'background-academico': application.academic_experience,
        'opportunity-name': application.opportunity_name,
        'op-id': application.opportunity_expa_id,
        'host-lc': application&.host_lc&.podio_id,
        'home-lc': application&.home_lc&.podio_id || [1023759520].sample,
        'home-mc': application&.home_mc&.podio_id, # Fixed to Brasil
        "celular": [
          {
            'type': 'mobile',
            value: application.exchange_participant.cellphone
          }
        ],
        'sdg-de-interesse': application.sdg_goal_index
      }
      # rubocop:enable Metrics/LineLength
      podio_item = Podio::Item.create(22140491, fields: params)
      application.update_attributes(
        podio_last_sync: Time.now,
        podio_id: podio_item.item_id
      )
      podio_item
    end


    private

    def map_status(status)
      mapper = {
        open: 1,
        applied: 2,
        accepted: 3,
        approved_tn_manager: 4,
        approved_ep_manager: 4,
        approved: 4,
        break_approved: 5,
        rejected: 6,
        withdrawn: 6,
        realized: 4,
        approval_broken: 6,
        realization_broken: 5,
        matched: 4,
        completed: 4
      }
      mapper[status]
    end

    def status_to_podio(status)
      mapping = {
        open: 6,
        applied: 1,
        accepted: 2,
        approved: 3,
        break_approved: 4,
        rejected: 5,
      }
      mapping[status.to_sym] || 6 # default other
    end

    def parse_date(date)
      return nil if date.nil?
      date.strftime('%Y-%m-%d %H:%M:%S')
    end

    def check_podio
      return if @@is_podio_initialized
      setup_podio
      authenticate_podio
      @@is_podio_initialized = true
    end

    def authenticate_podio
      Podio.client.authenticate_with_credentials(
        ENV['PODIO_USERNAME'],
        ENV['PODIO_PASSWORD']
      )
    end

    def setup_podio
      Podio.setup(
        api_key: ENV['PODIO_API_KEY'],
        api_secret: ENV['PODIO_API_SECRET']
      )
    end

    def delete_item(id)
      check_podio
      Podio::Item.delete(id)
    end

    def sync_icx_country(application)
      if !application&.home_mc&.podio_id.nil? || application.home_mc.nil?
        return
      end

      items = Podio::Item.find_by_filter_values(
        '22140562',
        'expa-id': {
          from: application.home_mc.expa_id,
          to: application.home_mc.expa_id
        }
      )
      if items.count != 1
        raise "Raise couldn't find MC in ICX Paises #{application.home_mc.id}/#{application.home_mc.name}"
      end

      application.home_mc.update_attributes(podio_id: items.all[0].item_id)
    end
  end

  def self.delete_icx_application(id)
    delete_item(id)
  end
end

