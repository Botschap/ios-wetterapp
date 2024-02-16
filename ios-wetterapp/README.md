#  Wetterapp

## Task händisch triggern

```e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"ios-wetterapp.fetchWeather"]```

## Task händisch failen 
```e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"ios-wetterapp.fetchWeather"]```


# TODOS

- [x] scheduel zum fetchen der Wetterdaten (unabhängig von der Location)
- [ ] Benachrichtigungen an den User, wenn es z.B. in 1h regnen sollte
- [ ] neue Wetterapi anbinden (OpenWeatherMap)[https://home.openweathermap.org/api_keys]

## UI

- [ ] Wetter anzeigen



