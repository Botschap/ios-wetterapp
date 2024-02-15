#  Wetterapp

## Task händisch triggern

```e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"ios-wetterapp.fetchWeather"]```

## Task händisch failen 
```e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"ios-wetterapp.fetchWeather"]```


# TODOS

- [ ] scheduel zum fetchen der Wetterdaten (unabhängig von der Location)
- [ ] Benachrichtigungen an den User, wenn es in 1h regnen sollte

## UI

- [ ] Wetter anzeigen


