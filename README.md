# Foodler

### DEMO APP


## Running Project

Before running project you need to configure firebase. Go to console.firebase.com and make project and place google-services.json file in android/app/

### Update Rule in Colud Firestore

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write;
    }
  }
}
```


## Screenshoots

## Features

- Products List
- Categories List
- Nice UI
- Organized Code
