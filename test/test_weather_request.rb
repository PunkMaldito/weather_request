require 'minitest/autorun'
require 'webmock/minitest'
require 'weather_request'

class TestWeatherRequest < Minitest::Test
  def test_success_request
    stub_request(:get, WeatherRequest::API_BASE_URL+"&key=1&q=Campo Grande")
      .to_return(status: 200, body: response, headers: { 'Content-Type' => 'application/json' })

    res = WeatherRequest.new.get(api_key: 1, query: 'Campo Grande')
    assert_equal(method_response, res)
  end

  def test_failed_request
    stub_request(:get, WeatherRequest::API_BASE_URL+"&key=1&q=Campo Grande")
      .to_return(status: 401, body: [], headers: { 'Content-Type' => 'application/json' })

    res = WeatherRequest.new.get(api_key: 1, query: 'Campo Grande')
    assert_nil(res)
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
        date: '2024-01-09',
        temperature: 33.0,
        condition: 'Parcialmente nublado'
      },
      forecast: [
        { date: '2024-01-10', temperature: 30.4 },
        { date: '2024-01-11', temperature: 28.4 },
        { date: '2024-01-12', temperature: 26.8 },
        { date: '2024-01-13', temperature: 26.9 },
        { date: '2024-01-14', temperature: 27.2 }
      ]
    }
  end
end
