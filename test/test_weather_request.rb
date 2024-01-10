require 'minitest/autorun'
require 'webmock/minitest'
require 'weather_request'

class TestWeatherRequest < Minitest::Test
  def test_success_request
    stub_request(:get, WeatherRequest::API_BASE_URL+"&key=1&q=Campo Grande")
      .to_return(status: 200, body: response, headers: { 'Content-Type' => 'application/json' })

    result = WeatherRequest.new.get(api_key: 1, query: 'Campo Grande')
    assert_equal(method_response, result)
  end

  def test_failed_request
    stub_request(:get, WeatherRequest::API_BASE_URL+"&key=1&q=Campo Grande")
      .to_return(status: 401, body: [], headers: { 'Content-Type' => 'application/json' })

    result = WeatherRequest.new.get(api_key: 1, query: 'Campo Grande')
    assert_nil(result)
  end

  protected

  def response
    {
      "location": {
        "name": "Campo Grande"
      },
      "current": {
        "temp_c": 33.0,
        "condition": {
          "text": "Parcialmente nublado"
        }
      },
      "forecast": {
        "forecastday": [
          {
            "date": "2024-01-09",
            "day": {
                "avgtemp_c": 33.0
            }
          },
          {
            "date": "2024-01-10",
            "day": {
                "avgtemp_c": 30.4
            }
          },
          {
            "date": "2024-01-11",
            "day": {
                "avgtemp_c": 28.4
            }
          },
          {
            "date": "2024-01-12",
            "day": {
                "avgtemp_c": 26.8
            }
          },
          {
            "date": "2024-01-13",
            "day": {
                "avgtemp_c": 26.9
            }
          },
          {
            "date": "2024-01-14",
            "day": {
                "avgtemp_c": 27.2
            }
          }
        ]
      }
    }.to_json
  end

  def method_response
    {
      city: 'Campo Grande',
      current: {
        date: '09/01',
        temperature: '33,0',
        condition: 'parcialmente nublado'
      },
      forecast: [
        { date: '10/01', temperature: '30,4' },
        { date: '11/01', temperature: '28,4' },
        { date: '12/01', temperature: '26,8' },
        { date: '13/01', temperature: '26,9' },
        { date: '14/01', temperature: '27,2' }
      ]
    }
  end
end
