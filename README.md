![Notre bannière]()
<br><br>
<h1 align="center"><strong>Cinesight</strong></h1>
<br>

Frontend : ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/rockethelll/Cinesight)
<br><br>
Backend : ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/TGianella/Cinesight-api)

<br><br>

## <ins>Features</ins>

<br><br>

## <ins>Technical stack</ins>

Backend: Ruby on Rails 7, HTML, CSS
Database: PostgreSQL
Frontend: React
CI/CD : GitHub Actions, Heroku
<br><br>

## <ins>Installation</ins>

* Clone repo
* `cd cinesight-api`
* `bundle install`
* `rails db:create db:migrate`
* `rails server`
<br><br>

## <ins>How to contribute</ins>

We are always on the lookout for new features to add to our watchlist app. If you feel like contributing, please open a new branch and open a pull request when your changes are made.
<br><br>

## <ins>Authors</ins>

* [@TGianella](https://www.github.com/TGianella)
* [@Steakinzer](https://www.github.com/Steakinzer)
* [@1996thomas](https://www.github.com/1996thomas)
* [@rockethelll](https://www.github.com/rockethelll)

Feel free to contact us if you have any question about the app.
<br><br>

## <ins>Project management tools</ins>

* [Notion](https://guttural-baboon-df4.notion.site/Cine-Sight-59b7ebc3f04c41db8a5efc3b0b9e3c3c)

## API documentation

**Current user**
----
  Fetches info about the currently logged in user

* **URL**

  <_/current_user_>

* **Method:**

  `GET`

* **Required header**

  * **Key** Authorization
    **Content:** `Bearer JWT` where JWT is the token sent back after successful login or signup
    
* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:** `{ id : integer, email : string, username : string, created_at : date }`
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "Signature has expired" }`

* **Sample Call:**

`curl --location 'http://127.0.0.1:4000/current_user' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI2YmM4MGVhZS1kZmUxLTQ0ZTctODFkMy1jMmZhOWY0Njk3NmIiLCJzdWIiOiI3Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjg3ODEyMjQ3LCJleHAiOjE2ODc4MTQwNDd9.Va6C1yUg8VBUO6B-KxtMXbPTVKSMT8ntjUd0RRx0dqg' \
--data ''`

* **Notes:**

