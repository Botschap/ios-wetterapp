#  Wetterapp

## Task händisch triggern

```e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"ios-wetterapp.fetchWeather"]```

## Task händisch failen 
```e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"ios-wetterapp.fetchWeather"]```


# TODOS

- [x] scheduel zum fetchen der Wetterdaten (unabhängig von der Location)
- [x] Benachrichtigungen an den User, wenn es z.B. in 1h regnen sollte
- [x] neue Wetterapi anbinden (OpenWeatherMap)[https://home.openweathermap.org/api_keys]
- [x] errorhandling

## UI

- [x] Wetter anzeigen



