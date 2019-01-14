module PodioHelper
  def map_podio(item)
    mapped = {}
    item.fields.each do |field|
      if field['values'][0]['value'].kind_of? String
        value = field['values'][0]['value']
        if (field['type'] == 'number')
          value = Float(value)
        end
        mapped["#{field['external_id']}".intern] = value
      elsif field['type'] == 'date'
        date = Date.parse(field['values'][0]['start'])
        mapped["#{field['external_id']}".intern] = date
      else
        mapped["#{field['external_id']}".intern] = field['values'][0]['value']['id']
      end
    end
    mapped
  end
end