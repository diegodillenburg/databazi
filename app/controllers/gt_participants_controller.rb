class GtParticipantsController < ApplicationController
  include ExchangeParticipantable

  expose :gt_participant
  expose :exchange_participantable, -> { gt_participant }
  expose :ep_fields, -> { gt_participant_fields }

  private

  def gt_participant_params
    nested_params.require(:gt_participant).permit(
      :scholarity,
      english_level_attributes: [:english_level],
      exchange_participant_attributes:
        exchange_participant_permitted_attributes,
      experience_attributes: experience_permitted_attributes
    )
  end

  def exchange_participant_permitted_attributes
    %i[
      id fullname email birthdate cellphone local_committee_id
      university_id college_course_id password
    ]
  end

  def experience_permitted_attributes
    %i[
      id language marketing information_technology management
    ]
  end

  def nested_params
    ActionController::Parameters.new(
      gt_participant: {
        scholarity: params[:gt_participant][:scholarity],
        english_level_attributes: english_level_params,
        exchange_participant_attributes: exchange_participant_params,
        experience_attributes: experience_params
      }
    )
  end

  def english_level_params
    params[:gt_participant]
      .slice(:english_level)
  end

  def exchange_participant_params
    params[:gt_participant]
      .slice(:id, :birthdate, :fullname, :email, :cellphone,
             :local_committee_id, :university_id, :college_course_id, :password)
  end

  def experience_params
    params[:gt_participant][:experience]
      .slice(:id, :language, :marketing, :information_technology, :management)
  end

  def gt_participant_fields
    {
      'email' => gt_participant.email,
      'fullname' => gt_participant.fullname,
      'cellphone' => gt_participant.cellphone,
      'birthdate' => gt_participant.birthdate,
      'podio_app' => 170_570_01
    }
  end
end
