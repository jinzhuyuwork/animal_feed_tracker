# Animal Feeds Tracker API

A Ruby on Rails API application for tracking animal feed formulations, feeds, and quantities to improve animal health management. This app allows users to manage animals, feeds, and formulations, and retrieve detailed information about feed quantities per animal. Built with **Ruby on Rails**, **PostgreSQL**, **Devise JWT authentication** and **Rack::Attack** for rate limiting.

## Features

- **Authentication**: Secure signup, login, and JWT-based API access.
- **Authorization**: Only admin users can create or update animals, feeds, or formulations. Non-admins have read-only access.
- **Rate Limitting**: Protects the API using Rack::Attack (default limits can be customized).
- **Animals Management**: Create, read, update for animals.
- **Feeds Management**: Create, read, update feeds.
- **Formulations**: Associate multiple feeds with animals and track quantities.
- **API Only**: Fully RESTful JSON API, ready for frontend consumption or mobile apps.
- **Testing**: Minitest unit and integration tests for API endpoints.
- **Code Quality**: Uses best practices, follows Rails conventions, and supports test coverage with SimpleCov.

## Architecture

- **Animal**: represents an animal type (Cow, Goat, etc.)  
- **Feed**: individual feed types or ingredients  
- **Formulation**: links animals to multiple feeds with quantity  

## Authentication

- Uses Devise + JWT for token-based authentication.
- Include header in requests:
```
Authorization: Bearer <your_jwt_token>
```
- Tokens are issued on login and required for all protected endpoints.

## Authorization
- **Admin-Only Actions:**
Only users with admin privileges can create or update Animals, Feeds, and Formulations.
- **Read Access:**
All authenticated users can view records but cannot modify them unless they are admins.
- **Role-Based Enforcement:**
Role checks are implemented at the controller level using before-action filters to ensure only admins can perform restricted actions.

## Rate Limiting

- The app uses Rack::Attack for rate limiting.
- Default configuration:
  - 5 login requests per 20 seconds per IP
  - 60 requests per minute per IP for authenticated API endpoints.
  - Blocklisted IPs or suspicious patterns can be throttled or blocked.
- When rate limits are exceeded, the API returns:
```
{
  "error": "Throttle limit reached. Try again later."
}
```

## Testing

- Minitest for unit, and integration tests.
- SimpleCov for test coverage:
```
bin/rails test
open coverage/index.html
```
- Integration tests cover API endpoints including controllers.

## Version Control & Deployment

### Git Version Control

- The project uses Git for version control.
- Commit changes frequently with descriptive commit messages.

### Hosting & Deployment

- Hosted on Render.com as a cloud-based Rails API service with base URL: https://animal-feed-tracker.onrender.com/
- GitHub Integration:
  - Push commits to the GitHub repository.
  - Render automatically detects new commits on the connected branch and triggers a fresh deployment.
- Manual Deployment:
  - You can also trigger a manual deploy from Render’s Dashboard under the Deploys tab.

## Getting Started

### Prerequisites

- Ruby 3.x
- Rails 8.x
- PostgreSQL
- Bundler (`gem install bundler`)

### Setup

- **Clone the repository**

```bash
git clone https://github.com/jinzhuyuwork/animal-feeds-tracker.git
cd animal-feeds-tracker
```

- **Install Gems**
```
bundle install
```
- **Setup database**
```
rails db:create
rails db:migrate
rails db:seed   # optional
```

- **Run tests**
```
bin/rails test
```

- **Start the server**
```
bin/rails server
```

- API available at http://localhost:3000/api/v1/

## API Endpoints

### Users
| Method | Endpoint         | Description                     |
| ------ | ---------------- | ------------------------------- |
| POST   | /users           | Sign up                         |
| POST   | /users/sign\_in  | Sign in                           |
| GET    | /users/me        | Show current login user details |
| POST   | /users/sign_out  | Sign out                        |

#### Sample request: login
```
POST /users/sign_in
{
  "user": {
    "email": "test@example.com",
    "password": "password123"
  }
}
````
#### Sample JSON Response
```
{
  "user": {
    "id":5,
    "email":"test@example.com",
    "created_at":"2025-09-17T05:36:44.111Z",
    "updated_at":"2025-09-17T05:36:44.111Z",
    "admin":false
  },
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNzU4MTI5MTQ1LCJleHAiOjE3NTgyMTU1NDUsImp0aSI6IjA4OTA5NmY5LTU3MDctNGJhOC1iYzdkLWZjNjI3NmFmMWUzNyJ9.pifYzS1KyhM3FFKYAVjcHk48lZn99RgQgllzmVRqHQY"
}
```
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
    "protein": 8.0,
    "fat": 3.5,
    "fiber": 5.0,
    "vitamins": "A,D,E",
    "minerals": "Ca" 
  }
}
````
#### Sample JSON Response
```
{
  "id": 1,
  "name": "Corn",
  "protein": 8.0,
  "fat": 3.5,
  "fiber": 5.0,
  "vitamins": "A,D,E",
  "minerals": "Ca" 
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

#### Sample request: Update formulation
```
PATCH /api/v1/formulation/1
{
  "formulation": {
    "name": "A New Formulation Name"
  }
}
```
#### Sample JSON Response
```
{
  "id": 1,
  "name": "A New Formulation Name",
  "description": "A starter formula for dog",
  "animal_id": 1,
  "feed_is": 2,
  "quantity": 2.5,
  "created_at": "2025-09-17T15:00:00Z",
  "updated_at": "2025-09-19T15:00:00Z"
}
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you’d like to change.

## Contact

- Email: janet.yu.2010@gmail.com
- GitHub: jinzhuyuwork
