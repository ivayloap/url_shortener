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

- Scalability - we can start by trying to estimate how much traffic the app will handle. This is done by, setting initial estimate of users per day/month/year, from which the average requests per second can be calculated. Then based on the response time of rails + DB response time and the specs of the server, we can see how much load this one server can handle. The app allows for horizontal scaling, as each instance of the app will use the counter in the database for uniquness, and this provides atomicity of the counter across instances.
If more than one instances are used, it's good idea to have load balancer on top of them. Which will redirect traffic, based on availability of the server and their respective specs (if one machine has 2x cpu/mem of others, it make sense to recieve 2x the traffic).
The database also can be scaled with sharding, and as we don't have any relations between records we can switch from RDBS to a NoSql DB like MongoDB for example.
For caching on the reading of frequently used urls, we can use redis (which also can be scaled).
And in front of each of the DB and Redis, a load balancer can also be placed, to handle the respective instances.

It's good practice to add analytics in the app, which will track the requests intensity over the day and also the progress with which the DB will be filled. Based on that statistic, the scaling can be adjusted. It's even possible to have dynamic scaling for example weekends in some regions could be slow, so scheduled scale down during the weekend can save money on infrastracture.


- Caching - for the 'decode' endnpoint, the app uses Redis caching (or if not available, the internal rails `:memory_store`). This will save fetching data from the databse, on calling on frequently fetched urls.

- Potential attacks
  - DDoS - logic can be added to prevent malicious spammy request, there are gems available like (https://github.com/rack/rack-attack), which use redis to store the IPs of the frequent offenders. And returning 429 (Too Many Request)
  - SQL / Code injection - Attacker can try to insert malicious code that can execute either in the database or in the code itself, using clausing statements strings. Those are mitigated by validations, and the sanitazation in active record. That's one of the benefets of useing active record over Raw sql.
  - Men in the Middle attacks are not concern here, as we're don't need authentication for this app.

# Open-Ended Questions
1. Please, explain your own words how you understand the DRY principle — Don't Repeat Yourself.
- The principle refers to reusability of code. It's related to recognizing patterns, where similarly working logic across the application can be extracted into a single location. This provides better code readability and maintanibility. It reduces also the code on the places where this reusable code is used.

2. What is your least favorite recommendation in the community Ruby style guide? https://rubystyle.guide/ Please, explain if you have one.
- I can't think of any, they all make sanse, and improve the overall code quality. My least favorite is the ABC metric size, but that's not in the guideline but rather rule enforced by rubocop.

3. Please, share a situation when you experienced working with a difficult coworker on a team. How was the coworker difficult and what did you do to resolve the situation to encourage the team's ongoing progress?
The coworker had difficult character, he was getting easilyt annoyed by little invonveniences in the project, was rude on calls with me and with the client. He was very knowledgable, and thus valuable for the project. What I was doing to get along, was trying my best not to annoy him. Being polite and patient with him proved to improve our relation and reduced the tention in the team. But most of all, reasonable communication proved to be the key.

4. Please, explain what is a dependency injection (DI). What place may it have in a typical Rails app? How would you structure a rails app to utilize dependency injection? If you think DI is not useful in Ruby/Rails applications, please, explain why.
In rails DI is used for passing instances of objects to class (service objects usually), it is useful as it saves boilerplate code, code is reused, and it also provides distinct separate between the business objects. DI is also used in the testing, for mocking and creating test doubles.

DI can become a problem if it's overused, for example in state machines (AASM), if too much logic is put in transitions in the state machines. It accounts for hard to trace logic and eventually hard to debug problems.