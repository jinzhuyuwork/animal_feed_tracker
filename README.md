# Animal Feeds Tracker API

A Rails 8 API application for tracking **animal feed formulations**.  
This app allows users to manage animals, feeds, and formulations, and retrieve detailed information about feed quantities per animal. Built with **Ruby on Rails**, **PostgreSQL**, and **Devise JWT authentication**.

---

## Features

- **User Authentication**: Secure signup, login, and JWT-based API access.
- **Animals Management**: Create, read, update for animals.
- **Feeds Management**: Create, read, update feeds.
- **Formulations**: Associate multiple feeds with animals and track quantities.
- **API Only**: Fully RESTful JSON API, ready for frontend consumption or mobile apps.
- **Testing**: Minitest unit and integration tests for API endpoints.
- **Code Quality**: Uses best practices, follows Rails conventions, and supports test coverage with SimpleCov.

---

## Architecture

- **Animal**: represents an animal type (Cow, Goat, etc.)  
- **Feed**: individual feed types or ingredients  
- **Formulation**: links animals to multiple feeds with quantity  

---

## Getting Started

### Prerequisites

- Ruby 3.x
- Rails 8.x
- PostgreSQL
- Node.js & Yarn (optional for frontend assets)
- Bundler (`gem install bundler`)

---

### Setup

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/animal-feeds-tracker.git
cd animal-feeds-tracker
```

2. **Install Gems**
```
bundle install
```
3. **Setup database**

rails db:create
rails db:migrate
rails db:seed   # optional

4. **Run tests**
```
bin/rails test
```

5. **Start the server**
```
bin/rails server
```

API available at http://localhost:3000/api/v1/

## API Endpoints

### Users
| Method | Endpoint         | Description                     |
| ------ | ---------------- | ------------------------------- |
| POST   | /users/sign\_in  | Login                           |
| GET    | /users/me        | Show Ucurrent login user details|

### Animals
| Method | Endpoint                   | Description                                     |
| ------ | -------------------------- | ----------------------------------------------- |
| GET    | /api/v1/animals_with_feeds | Show all animals with their quantities of feeds |
| GET    | /api/v1/animals            | List all animals                                |
| POST   | /api/v1/animals            | Create a new animal                             |
| GET    | /api/v1/animals/\:id       | Show animal details                             |
| PATCH  | /api/v1/animals/\:id       | Update animal                                   |

#### Sample request: Show all animals with their quantities of feeds
```
GET /api/v1/animals_with_feeds
```
#### Sample JSON Response
```

[
	{
	  "id": 11,
	  "name": "Bessie",
	  "species": "Cow",
	  "age": 4,
	  "weight": "450.5",
	  "formulations": [
	    {
	      "name": "High Protein",
	      "description": "This is a formula with high protein",
	      "quantity": "5.0",
	      "feed": {
	        "id": 11,
	        "name": "Corn Mix - fresh",
	        "protein": "8.0",
	        "fiber": "5.0",
	        "fat": "3.5"
	      }
	    },
	    {
	      "name": "Low fat",
	      "description": "This is a formula with low fat",
	      "quantity": "2.0",
	      "feed": {
	        "id": 12,
	        "name": "Soy Meal",
	        "protein": "44.0",
	        "fiber": "6.0",
	        "fat": "1.5"
	      }
	    }
	  ]
	},
	{
	  "id": 12,
	  "name": "Clucky",
	  "species": "Chicken",
	  "age": 1,
	  "weight": "2.3",
	  "formulations": [
	    {
	      "name": "Low protein",
	      "description": "This is a formula with low protein",
	      "quantity": "0.5",
	      "feed": {
	        "id": 11,
	        "name": "Corn Mix - fresh",
	        "protein": "8.0",
	        "fiber": "5.0",
	        "fat": "3.5"
	      }
	    },
	   {
	     "name": "Balance feed",
	     "description": "This is a formula with balance nutrition",
	     "quantity": "0.3",
	     "feed": {
	       "id": 13,
	       "name": "Barley Feed",
	       "protein": "10.0",
	       "fiber": "8.0",
	       "fat": "2.0"
	     }
	   }
	 ]
   }
]
```

### Feeds
| Method | Endpoint           | Description       |
| ------ | ------------------ | ----------------- |
| GET    | /api/v1/feeds      | List all feeds    |
| POST   | /api/v1/feeds      | Create a new feed |
| GET    | /api/v1/feeds/\:id | Show feed details |
| PATCH  | /api/v1/feeds/\:id | Update feed       |

#### Sample Request: Create Feed
```
POST /api/v1/feeds
{
  "feed": {
    "name": "Corn",
    "unit": "kg"
  }
}
````
#### Sample JSON Response
```
{
  "id": 1,
  "name": "Corn",
  "unit": "kg",
  "created_at": "2025-09-17T15:05:00Z",
  "updated_at": "2025-09-17T15:05:00Z"
}
```

### Formulations
| Method | Endpoint                  | Description              |
| ------ | ------------------------- | ------------------------ |
| GET    | /api/v1/formulations      | List all formulations    |
| POST   | /api/v1/formulations      | Create a new formulation |
| GET    | /api/v1/formulations/\:id | Show formulation details |
| PATCH  | /api/v1/formulations/\:id | Update formulation       |

#### Sample request: Create formulation
```
POST /api/v1/animals
{
  "animal": {
    "name": "Goat",
    "species": "Capra"
  }
}
```
#### Sample JSON Response
```
{
  "id": 2,
  "name": "Goat",
  "species": "Capra",
  "created_at": "2025-09-17T15:00:00Z",
  "updated_at": "2025-09-17T15:00:00Z"
}
```
## Authentication

* Uses Devise + JWT for token-based authentication.

* Include header in requests:
```
Authorization: Bearer <your_jwt_token>
```
* Tokens are issued on login and required for all protected endpoints.

## Testing

* Minitest for unit, controller, and integration tests.

* SimpleCov for test coverage:
```
bin/rails test
open coverage/index.html
```

* Integration tests cover API endpoints including controllers.

## Contributing

* Fork the repository

* Create a feature branch

* Commit your changes

* Push to branch

* Open a pull request

## License

* MIT License

## Contact

* Email: janet.yu.2010@gmail.com

* GitHub: jinzhuyuwork
