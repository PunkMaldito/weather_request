require 'net/http'
require 'json'
require 'date'

class WeatherRequest
  API_BASE_URL = 'http://api.weatherapi.com/v1/forecast.json?days=6&aqi=no&alerts=no&lang=pt'

  def get(api_key:, query:)
    uri = URI(API_BASE_URL+"&key=#{api_key}&q=#{query}")
    api_response = Net::HTTP.get_response(uri)

    clean_response(JSON.parse(api_response.body)) if api_response.is_a?(Net::HTTPSuccess)
  end

  protected

  def clean_response(parsed_json)
    {}.tap do |hash|
      hash[:city] = parsed_json['location']['name']
      hash[:current] = { date: Date.today.strftime("%Y-%m-%d"),
                         temperature: parsed_json['current']['temp_c'],
                         condition: parsed_json['current']['condition']['text'] }
      hash[:forecast] = []

      parsed_json['forecast']['forecastday'].drop(1).each do |forecastday|
        hash[:forecast] << { date: forecastday['date'],
                             temperature: forecastday['day']['avgtemp_c'] }
      end
    end
  end
end
