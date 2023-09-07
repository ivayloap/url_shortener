URL Shortener

This is a Ruby on Rails API app, that provides way to shorten url.
It has 2 endpoints:

## Encode Endpoint API

**URL**: `POST /encode`

**Request Body**
```json5
{
  "url": "https://codesubmit.io/library/react"
}
```

### Success Response

**Code** : `200 OK`

**Content example**

```json5
{
  "url": "https://codesubmit.io/library/react",
  "short_url": "https://short.est/GeAi9K"
}
```


### Error Response

**Code** : `400 BAD REQUEST`

**Content example**

```json5
{
  "error": "The provided URI is not correct -> 'hps://www.'"
}
```

## Decode Endpoint API

**URL**: `POST /decode`

**Request Body**
```json5
{
  "short_url": "https://short.est/GeAi9K"
}
```

### Success Response

**Code** : `200 OK`

**Content example**

```json5
{
  "url": "https://codesubmit.io/library/react",
  "short_url": "https://short.est/GeAi9K"
}
```


### Error Response

**Code** : `400 BAD REQUEST`

**Content example**

```json5
{
  "error": "Resource not found"
}
```
