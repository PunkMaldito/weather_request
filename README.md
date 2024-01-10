# Weather Request

A simple request library for weather information for the current and the next 5 days, requesting from [Weather API](https://weatherapi.com).


## Install

```shell
gem install weather_request
```
or
```ruby
require 'weather_request'
```

## Usage

```ruby
WeatherRequest.new.get(api_key: <your-weather-api-key>, query: <city-name-or-geolocation>)
```
That will return a hash with this structure:
```ruby
{
  city: 'Campo Grande',
  current: {
    date: '09/01',
    temperature: '33,2',
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
```
