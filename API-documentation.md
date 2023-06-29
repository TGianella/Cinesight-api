<h1 align="center"><strong>API documentation</strong></h1>

# Table of contents

- [User account](#user-account)
  - [Sign up](#sign-up)
  - [Login](#login)
  - [Logout](#logout)
  - [Current user](#current-user)
  - [Get password recovery email](#get-password-recovery-email)
  - [Change password after recovery](#change-password-after-recovery)
- [User profile](#user-profile)
  - [Show profile](#show-profile)
  - [Edit profile](#edit-profile)
  - [Delete profile](#delete-profile)
- [Movies](#movies)
  - [Now playing](#now-playing)
  - [Popular](#popular)
  - [Top rated](#top-rated)
  - [Upcoming](#upcoming)
  - [Search](#search)
  - [Show movie details](#show-movie-details)
- [Watchlists](#watchlists)
  - [Show watchlist](#show-watchlist)
  - [Add movie to watchlist](#add-movie-to-watchlist)
  - [Remove movie from watchlist](#remove-movie-from-watchlist)

# User account

***Sign up***
----
  Signs a user up.

* **URL**

  `/signup`

* **Method:**

  `POST`

* **Data Params**

  ```JSON
  {
    "user": {
      "email": "email",
      "username": "username",
      "password": "password"
    }
  }
  ```

* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:** `{ message: "Signed up sucessfully." }`
 
* **Error Response:**

  * **Code:** 422 UNPROCESSABLE ENTITY <br />
    **Content:** `{ error : "User couldn't be created successfully." }`

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/signup' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "user": {
          "email": "test3@test.com",
          "password": "foobar",
          "username": "test"
      }
  }'
```

***Login***
----
  Logs a user in.

* **URL**

  `/login`

* **Method:**

  `POST`

* **Data Params**

  ```JSON
  {
    "user": {
      "email": "email",
      "password": "password"
    }
  }
  ```

* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:** `{ message: "Logged in sucessfully." }`
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "Invalid Email or password" }`

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/login' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "user": {
          "email": "test@test.com",
          "password": "foobar"
      }
  }'
```

***Logout***
----
  Logs a user out.

* **URL**

  `/logout`

* **Method:**

  `DELETE`

* **Required header**

  * **Key:** Authorization <br />
    **Content:** `Bearer JWT` where JWT is the token sent back after successful login or signup
    
* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:** `{ message: "logged out sucessfully." }`
 
* **Error Response:**

  * **Code:** 404 NOT FOUND <br />
    **Content:** `{ error : "Couldn't find an active session." }`

* **Sample Call:**

```
  curl --location --request DELETE 'http://127.0.0.1:4000/logout' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI2YmM4MGVhZS1kZmUxLTQ0ZTctODFkMy1jMmZhOWY0Njk3NmIiLCJzdWIiOiI3Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjg3OTQ3MTI5LCJleHAiOjE2ODc5NDg5Mjl9.ch5gH_PvJLAgqEg3QrQ6ACjuq3KSWSuDQVvAbYS-wsE' \
  --data ''
```

***Current user***
----
  Fetches info about the currently logged in user.

* **URL**

  `/current_user`

* **Method:**

  `GET`

* **Required header**

  * **Key:** Authorization <br />
    **Content:** `Bearer JWT` where JWT is the token sent back after successful login or signup
    
* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:** `{ id : integer, email : string, username : string, created_at : date }`
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You need to sign in or sign up before continuing." }`

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/current_user' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI2YmM4MGVhZS1kZmUxLTQ0ZTctODFkMy1jMmZhOWY0Njk3NmIiLCJzdWIiOiI3Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjg3ODEyMjQ3LCJleHAiOjE2ODc4MTQwNDd9.Va6C1yUg8VBUO6B-KxtMXbPTVKSMT8ntjUd0RRx0dqg' \
  --data ''
```

***Get password recovery email***
----
  Sends an email to the user with an url to get to the password recovery page.

* **URL**

  `/password`

* **Method:**

  `POST`

* **Data Params**

  ```JSON
  {
    "user": {
      "email": "email",
    }
  }
  ```
* **Required header**

  * **Key** Authorization <br />
    **Content:** `Bearer JWT` where JWT is the token sent back after successful login or signup

* **Success Response:**
  
  * **Code:** 200 <br />
 
* **Error Response:**

  * **Code:** 422 UNPROCESSABLE ENTITY <br />

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/password' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "user": {
          "email": "test@test.com"
      }
  }'
```

***Change password after recovery***
----
  Defines the new pasword to be used after recovery.

* **URL**

  `/password`

* **Method:**

  `PATCH`

* **Data Params**

```JSON
  {
    "user": {
        "reset_password_token": "reset_password token",
        "password": "newpassword",
        "password_confirmation": "newpassword"
    }
  }
```

* **Success Response:**
  
  * **Code:** 200 <br />
 
* **Error Response:**

  * **Code:** 422 UNPROCESSABLE ENTITY <br />

* **Sample Call:**

```
  curl --location --request PATCH 'http://127.0.0.1:4000/password' \
  --header 'Content-Type: application/json' \
  --data '{
      "user": {
          "reset_password_token": "yurzPiJr6qGLWhMdAqsw",
          "password": "password",
          "newpassword": "password"
      }
  }'
```

# User profile

***Show profile***
----
  Fetches info about the profile info of the currently logged in user.

* **URL**

  `/profile`

* **Method:**

  `GET`

* **Required header**

  * **Key:** Authorization <br />
    **Content:** `Bearer JWT` where JWT is the token sent back after successful login or signup
    
* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:** `{ id : integer, email : string, username : string, created_at : date }`
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You need to sign in or sign up before continuing." }`

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/profile' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3ZTc0YThmMi02NDM4LTRlNjUtYThmMC0wNzJhNzMyZjc3NzIiLCJzdWIiOiIxMSIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTY4Nzg2ODY3OSwiZXhwIjoxNjg3ODcwNDc5fQ.xRSgXMwD0dCQP0gLKM0v3IStaoT_sJQ97JtBhydHIJU' \
  --data ''
```

***Edit profile***
----
  Updates user profile info (except password).

* **URL**

  `/profile`

* **Method:**

  `PATCH`

* **Required header**

  * **Key:** Authorization <br />
    **Content:** `Bearer JWT` where JWT is the token sent back after successful login or signup
    
* **Data Params**

```JSON
  {
    "user": {
        "email": "newemail",
        "username": "newusername"
    }
  }
```

* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:**
    ```JSON
      {
        "status": {
            "code": 200,
            "message": "Updated profile sucessfully."
        },
        "data": {
            "id": 1,
            "email": "email",
            "username": "username",
            "created_at": "2023-06-26T16:05:29.855Z"
        }
      }
    ```
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You need to sign in or sign up before continuing." }`

  * **Code:** 422 UNPROCESSABLE ENTITY <br />
    **Content:** `{ error : "Profile couldn't be updated successfully." }`

* **Sample Call:**

```
  curl --location --request PATCH 'http://127.0.0.1:4000/profile' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3YTJkZWFkNC1jNmFiLTQyYzAtYWIyNi0yZTU0MGZhNDgyYmYiLCJzdWIiOiI3Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjg3OTU0Mjk5LCJleHAiOjE2ODc5NTYwOTl9.ufvWrrxGwhJIJqeAvnpOSlkkx7MosoOQYH786lLDp_U' \
  --data '{
      "user": {
          "username": "test"
      }
  }'
```

***Delete profile***
----
  Deletes user account.

* **URL**

  `/profile`

* **Method:**

  `DELETE`

* **Required header**

  * **Key:** Authorization <br />
    **Content:** `Bearer JWT` where JWT is the token sent back after successful login or signup

* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:** `{ message : "deleted account succesfully}`
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You need to sign in or sign up before continuing." }`

  * **Code:** 404 NOT FOUND <br />
    **Content:** `{ error : "Couldn't find user account to delete." }`

* **Sample Call:**

```
  curl --location --request DELETE 'http://127.0.0.1:4000/profile' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3YTJkZWFkNC1jNmFiLTQyYzAtYWIyNi0yZTU0MGZhNDgyYmYiLCJzdWIiOiI3Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjg3OTU0Mjk5LCJleHAiOjE2ODc5NTYwOTl9.ufvWrrxGwhJIJqeAvnpOSlkkx7MosoOQYH786lLDp_U' \
  --data ''
```

# Movies

***Now playing***
----
  Fetches and returns a list of movies currently playing in theaters, ranked by popularity.

* **URL**

  `/movies/now_playing`

* **Method:**

  `GET`
    
* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:**
    ```JSON
      {
        "dates": {
            "maximum": "2023-06-26",
            "minimum": "2023-05-09"
        },
        "page": 1,
        "results": [
            {
                "adult": false,
                "backdrop_path": "/4XM8DUTQb3lhLemJC51Jx4a2EuA.jpg",
                "genre_ids": [
                    28,
                    80,
                    53
                ],
                "id": 385687,
                "original_language": "en",
                "original_title": "Fast X",
                "overview": "Over many missions and against impossible odds, Dom Toretto and his family have outsmarted, out-nerved and outdriven every foe in their path. Now, they confront the most lethal opponent they've ever faced: A terrifying threat emerging from the shadows of the past who's fueled by blood revenge, and who is determined to shatter this family and destroy everything—and everyone—that Dom loves, forever.",
                "popularity": 4654.279,
                "poster_path": "/fiVW06jE7z9YnO4trhaMEdclSiC.jpg",
                "release_date": "2023-05-17",
                "title": "Fast X",
                "video": false,
                "vote_average": 7.3,
                "vote_count": 2093
            },
            {
                "adult": false,
                "backdrop_path": "/xXp7TbCOKe4lB65ngkt3CuhsiAa.jpg",
                "genre_ids": [
                    28,
                    53
                ],
                "id": 697843,
                "original_language": "en",
                "original_title": "Extraction 2",
                "overview": "Tasked with extracting a family who is at the mercy of a Georgian gangster, Tyler Rake infiltrates one of the world's deadliest prisons in order to save them. But when the extraction gets hot, and the gangster dies in the heat of battle, his equally ruthless brother tracks down Rake and his team to Sydney, in order to get revenge.",
                "popularity": 2494.01,
                "poster_path": "/7gKI9hpEMcZUQpNgKrkDzJpbnNS.jpg",
                "release_date": "2023-06-09",
                "title": "Extraction 2",
                "video": false,
                "vote_average": 7.7,
                "vote_count": 910
            },
            {...}
        ],
        "total_pages": 87,
        "total_results": 1728
      }
    ```
 
* **Error Response:**

  * **Code:** 500 INTERNAL SERVER ERROR <br />

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/movies/now_playing' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3YTJkZWFkNC1jNmFiLTQyYzAtYWIyNi0yZTU0MGZhNDgyYmYiLCJzdWIiOiI3Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjg3OTU0Mjk5LCJleHAiOjE2ODc5NTYwOTl9.ufvWrrxGwhJIJqeAvnpOSlkkx7MosoOQYH786lLDp_U' \
  --data ''
```

***Popular***
----
  Fetches and returns a list of movies ordered by popularity.

* **URL**

  `/movies/popular`

* **Method:**

  `GET`
    
* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:**
    ```JSON
      {
        "page": 1,
        "results": [
            {
                "adult": false,
                "backdrop_path": "/e2Jd0sYMCe6qvMbswGQbM0Mzxt0.jpg",
                "genre_ids": [
                    28,
                    80,
                    53
                ],
                "id": 385687,
                "original_language": "en",
                "original_title": "Fast X",
                "overview": "Over many missions and against impossible odds, Dom Toretto and his family have outsmarted, out-nerved and outdriven every foe in their path. Now, they confront the most lethal opponent they've ever faced: A terrifying threat emerging from the shadows of the past who's fueled by blood revenge, and who is determined to shatter this family and destroy everything—and everyone—that Dom loves, forever.",
                "popularity": 4052.245,
                "poster_path": "/fiVW06jE7z9YnO4trhaMEdclSiC.jpg",
                "release_date": "2023-05-17",
                "title": "Fast X",
                "video": false,
                "vote_average": 7.3,
                "vote_count": 2141
            },
            {
                "adult": false,
                "backdrop_path": "/fhquRW28vRZHr26orSaFFnhYIA0.jpg",
                "genre_ids": [
                    28,
                    53
                ],
                "id": 697843,
                "original_language": "en",
                "original_title": "Extraction 2",
                "overview": "Tasked with extracting a family who is at the mercy of a Georgian gangster, Tyler Rake infiltrates one of the world's deadliest prisons in order to save them. But when the extraction gets hot, and the gangster dies in the heat of battle, his equally ruthless brother tracks down Rake and his team to Vienna, in order to get revenge.",
                "popularity": 2167.075,
                "poster_path": "/7gKI9hpEMcZUQpNgKrkDzJpbnNS.jpg",
                "release_date": "2023-06-09",
                "title": "Extraction 2",
                "video": false,
                "vote_average": 7.6,
                "vote_count": 948
            },
            {...}
        ],
        "total_pages": 38904,
        "total_results": 778063
      }
    ```
 
* **Error Response:**

  * **Code:** 500 INTERNAL SERVER ERROR <br />

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/movies/popular' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3YTJkZWFkNC1jNmFiLTQyYzAtYWIyNi0yZTU0MGZhNDgyYmYiLCJzdWIiOiI3Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjg3OTU0Mjk5LCJleHAiOjE2ODc5NTYwOTl9.ufvWrrxGwhJIJqeAvnpOSlkkx7MosoOQYH786lLDp_U' \
  --data ''
```

***Top rated***
----
  Fetches and returns a list of movies ordered by rating.

* **URL**

  `/movies/top_rated`

* **Method:**

  `GET`
    
* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:**
    ```JSON
      {
        "page": 1,
        "results": [
            {
                "adult": false,
                "backdrop_path": "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg",
                "genre_ids": [
                    18,
                    80
                ],
                "id": 238,
                "original_language": "en",
                "original_title": "The Godfather",
                "overview": "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
                "popularity": 122.345,
                "poster_path": "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
                "release_date": "1972-03-14",
                "title": "The Godfather",
                "video": false,
                "vote_average": 8.7,
                "vote_count": 18146
            },
            {
                "adult": false,
                "backdrop_path": "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg",
                "genre_ids": [
                    18,
                    80
                ],
                "id": 278,
                "original_language": "en",
                "original_title": "The Shawshank Redemption",
                "overview": "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
                "popularity": 102.647,
                "poster_path": "/lyQBXzOQSuE59IsHyhrp0qIiPAz.jpg",
                "release_date": "1994-09-23",
                "title": "The Shawshank Redemption",
                "video": false,
                "vote_average": 8.7,
                "vote_count": 24024
            },
            {...}
        ],
        "total_pages": 560,
        "total_results": 11192
      }
    ```
 
* **Error Response:**

  * **Code:** 500 INTERNAL SERVER ERROR <br />

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/movies/top_rated' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3YTJkZWFkNC1jNmFiLTQyYzAtYWIyNi0yZTU0MGZhNDgyYmYiLCJzdWIiOiI3Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjg3OTU0Mjk5LCJleHAiOjE2ODc5NTYwOTl9.ufvWrrxGwhJIJqeAvnpOSlkkx7MosoOQYH786lLDp_U' \
  --data ''
```

***Upcoming***
----
  Fetches and returns a list of popular upcoming movies.

* **URL**

  `/movies/upcoming`

* **Method:**

  `GET`
    
* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:**
    ```JSON
      {
        "dates": {
            "maximum": "2023-07-26",
            "minimum": "2023-07-05"
        },
        "page": 1,
        "results": [
            {
                "adult": false,
                "backdrop_path": "/cSYLX73WskxCgvpN3MtRkYUSj1T.jpg",
                "genre_ids": [
                    16,
                    35,
                    10751,
                    14,
                    10749
                ],
                "id": 976573,
                "original_language": "en",
                "original_title": "Elemental",
                "overview": "In a city where fire, water, land and air residents live together, a fiery young woman and a go-with-the-flow guy will discover something elemental: how much they have in common.",
                "popularity": 1178.288,
                "poster_path": "/8riWcADI1ekEiBguVB9vkilhiQm.jpg",
                "release_date": "2023-06-14",
                "title": "Elemental",
                "video": false,
                "vote_average": 7.4,
                "vote_count": 223
            },
            {
                "adult": false,
                "backdrop_path": "/fEe2csLOUsTyaLdCccVJfFeJzhx.jpg",
                "genre_ids": [
                    878,
                    28,
                    12
                ],
                "id": 298618,
                "original_language": "en",
                "original_title": "The Flash",
                "overview": "When his attempt to save his family inadvertently alters the future, Barry Allen becomes trapped in a reality in which General Zod has returned and there are no Super Heroes to turn to. In order to save the world that he is in and return to the future that he knows, Barry's only hope is to race for his life. But will making the ultimate sacrifice be enough to reset the universe?",
                "popularity": 891.684,
                "poster_path": "/rktDFPbfHfUbArZ6OOOKsXcv0Bm.jpg",
                "release_date": "2023-06-13",
                "title": "The Flash",
                "video": false,
                "vote_average": 6.7,
                "vote_count": 658
            },
        ],
        "total_pages": 16,
        "total_results": 319
      }
    ```
 
* **Error Response:**

  * **Code:** 500 INTERNAL SERVER ERROR <br />

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/movies/upcoming' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3YTJkZWFkNC1jNmFiLTQyYzAtYWIyNi0yZTU0MGZhNDgyYmYiLCJzdWIiOiI3Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjg3OTU0Mjk5LCJleHAiOjE2ODc5NTYwOTl9.ufvWrrxGwhJIJqeAvnpOSlkkx7MosoOQYH786lLDp_U' \
  --data ''
```

***Search***
----
  Fetches and returns a list of movies related to the query string provided.

* **URL**

  `/movies/search?query=`

* **Method:**

  `GET`

*  **URL Params**

   **Required:**
 
   `query=[string]`
    
* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:**
    ```JSON
      {
        "page": 1,
        "results": [
            {
                "adult": false,
                "backdrop_path": "/xySCWwZVuU03xOsJfs1Qk8yG2DF.jpg",
                "genre_ids": [
                    18,
                    10749
                ],
                "id": 226979,
                "original_language": "en",
                "original_title": "Test",
                "overview": "San Francisco 1985. Frankie est un jeune danseur qui vient d’intégrer une des plus prestigieuses troupes de danse contemporaine de la ville. Il fait la connaissance de Todd, un des danseurs de la troupe. Leur rencontre ne tarde pas à dépasser le cadre de la danse. Des manifestations contre la communauté gay voient le jour. Elles sont liées à la panique créée par la maladie du VIH que l'on vient de découvrir. Ensemble, Frankie et Todd évolueront dans ces événements hostiles mais aussi parfois plein d’espoir.",
                "popularity": 4.882,
                "poster_path": "/tQBUPALd5JgeNfSubgzyPxc0e9F.jpg",
                "release_date": "2013-06-29",
                "title": "San Francisco 1985",
                "video": false,
                "vote_average": 6.4,
                "vote_count": 135
            },
            {
                "adult": false,
                "backdrop_path": null,
                "genre_ids": [
                    18
                ],
                "id": 617120,
                "original_language": "en",
                "original_title": "Test",
                "overview": "Kurt Longson tries to avenge his daughters death. To succeed he has to battle with his conscience and morality to realize true love.",
                "popularity": 2.44,
                "poster_path": "/5F6eKWJNHfYgHf2PDsb73fmAdK8.jpg",
                "release_date": "2018-05-22",
                "title": "Test",
                "video": false,
                "vote_average": 3.5,
                "vote_count": 44
            },
            {...}
        ],
        "total_pages": 64,
        "total_results": 1271
      }
    ```
 
* **Error Response:**

  * **Code:** 500 INTERNAL SERVER ERROR <br />

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/movies/search?query=test' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3YTJkZWFkNC1jNmFiLTQyYzAtYWIyNi0yZTU0MGZhNDgyYmYiLCJzdWIiOiI3Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjg3OTU0Mjk5LCJleHAiOjE2ODc5NTYwOTl9.ufvWrrxGwhJIJqeAvnpOSlkkx7MosoOQYH786lLDp_U' \
  --data ''
```

***Show movie details***
----
  Fetches and returns details for a given movie.

* **URL**

  `/movie/:id`

* **Method:**

  `GET`

*  **URL Params**

   **Required:**
 
   `id=[integer]`
    
* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:**
    ```JSON
      {
        "id": 3,
        "title": "Ombres au paradis",
        "vote_average": 7.2,
        "vote_count": 272,
        "poster_path": "/nHuOGQsG7imhoLfcGEyYnioIomo.jpg",
        "original_title": "Varjoja paratiisissa",
        "overview": "L’histoire d’amour d’un conducteur de camion à ordures, Nikander, et d’une caissière de supermarché, Ilona. Un des rares films du nouveau cinéma finlandais enfin sur nos écrans.",
        "release_date": "1986-10-17",
        "tagline": "",
        "created_at": "2023-06-28T12:49:53.682Z",
        "updated_at": "2023-06-28T12:49:53.682Z",
        "director": "Aki Kaurismäki",
        "genres": [
            {
                "id": 18,
                "name": "Drame"
            },
            {
                "id": 35,
                "name": "Comédie"
            },
            {
                "id": 10749,
                "name": "Romance"
            }
        ]
      }
    ```
 
* **Error Response:**

  * **Code:** 500 INTERNAL SERVER ERROR <br />

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/movie/3' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3YTJkZWFkNC1jNmFiLTQyYzAtYWIyNi0yZTU0MGZhNDgyYmYiLCJzdWIiOiI3Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjg3OTU0Mjk5LCJleHAiOjE2ODc5NTYwOTl9.ufvWrrxGwhJIJqeAvnpOSlkkx7MosoOQYH786lLDp_U' \
  --data ''
```

# Watchlists

***Show watchlist***
----
  Fetches and returns a list of movies in the current user's watchlist.

* **URL**

  `/watchlist`

* **Method:**

  `GET`

* **Required header**

  * **Key:** Authorization <br />
    **Content:** `Bearer JWT` where JWT is the token sent back after successful login or signup
    
* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:** 
    ```JSON
      [
        {
            "id": 2,
            "title": "Ariel",
            "vote_average": 7.1,
            "vote_count": 255,
            "poster_path": "/4HTJHLPLvhDG4D0m8IcUMh7i9h4.jpg",
            "original_title": "Ariel",
            "overview": "Salla, petite ville minière de la Laponie. Taisto Kasurinen, mineur, hérite d’une « belle américaine » après le suicide de son propriétaire. Il retire toute ses économies de la banque et part à Helsinki. La capitale l’accueille froidement : il se fait voler son argent et se retrouve en prison. Cependant il a eu le temps de rencontrer Irmeli, jeune femme débordée, et son petit garçon. Ils réussiront a faire évader Taisto. Poursuivis par la police, ils sont bien décidés a tout faire pour s’en sortir.",
            "release_date": "1988-10-21",
            "tagline": "",
            "created_at": "2023-06-26T09:33:08.384Z",
            "updated_at": "2023-06-26T09:33:08.384Z",
            "director": null
        },
        {
            "id": 3,
            "title": "Ombres au paradis",
            "vote_average": 7.2,
            "vote_count": 272,
            "poster_path": "/nHuOGQsG7imhoLfcGEyYnioIomo.jpg",
            "original_title": "Varjoja paratiisissa",
            "overview": "L’histoire d’amour d’un conducteur de camion à ordures, Nikander, et d’une caissière de supermarché, Ilona. Un des rares films du nouveau cinéma finlandais enfin sur nos écrans.",
            "release_date": "1986-10-17",
            "tagline": "",
            "created_at": "2023-06-28T12:49:53.682Z",
            "updated_at": "2023-06-28T12:49:53.682Z",
            "director": "Aki Kaurismäki"
        }
      ]
    ```
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You need to sign in or sign up before continuing." }`

* **Sample Call:**

```
  curl --location 'http://127.0.0.1:4000/profile' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3ZTc0YThmMi02NDM4LTRlNjUtYThmMC0wNzJhNzMyZjc3NzIiLCJzdWIiOiIxMSIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTY4Nzg2ODY3OSwiZXhwIjoxNjg3ODcwNDc5fQ.xRSgXMwD0dCQP0gLKM0v3IStaoT_sJQ97JtBhydHIJU' \
  --data ''
```

***Add movie to watchlist***
----
  Adds a movie to current user's watchlist.

* **URL**

  `/watchlist/:movie_id`

* **Method:**

  `POST`

* **Required header**

  * **Key:** Authorization <br />
    **Content:** `Bearer JWT` where JWT is the token sent back after successful login or signup
    
*  **URL Params**

   **Required:**
 
   `movie_id=[integer]`
    
* **Success Response:**
  
  * **Code:** 200 <br />
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You need to sign in or sign up before continuing." }`

* **Sample Call:**

```
  curl --location --request POST 'http://127.0.0.1:4000/watchlist/5' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJkNjU1OGM3YS1mZjYyLTRmMTgtOTViZS01MTIxMzczNGVhYjMiLCJzdWIiOiIxMiIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTY4Nzk1Nzg2MiwiZXhwIjoxNjg3OTU5NjYyfQ.F_FYnzKFNS8i0923CL5Bne5tXhF3Sm61P4pfm7Ulm4Y' \
  --data ''
```

***Remove movie from watchlist***
----
  Removes a movie from current user's watchlist.

* **URL**

  `/watchlist/:movie_id`

* **Method:**

  `DELETE`

* **Required header**

  * **Key:** Authorization <br />
    **Content:** `Bearer JWT` where JWT is the token sent back after successful login or signup

* **Success Response:**
  
  * **Code:** 200 <br />
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You need to sign in or sign up before continuing." }`

  * **Code:** 404 NOT FOUND <br />

* **Sample Call:**

```
  curl --location --request DELETE 'http://127.0.0.1:4000/watchlist/5' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJkNjU1OGM3YS1mZjYyLTRmMTgtOTViZS01MTIxMzczNGVhYjMiLCJzdWIiOiIxMiIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTY4Nzk1Nzg2MiwiZXhwIjoxNjg3OTU5NjYyfQ.F_FYnzKFNS8i0923CL5Bne5tXhF3Sm61P4pfm7Ulm4Y' \
  --data ''
```

