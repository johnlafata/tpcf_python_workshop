# FastAPI RESTful API Workshop

This project demonstrates how to build a RESTful API using FastAPI with a books endpoint.

## Getting Started

### Prerequisites
- Python 3.7+
- pip

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/fastapi-books-api.git
cd fastapi-books-api

# Create a virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install fastapi uvicorn
```

## Project Structure

```
├── app
│   ├── __init__.py
│   ├── main.py
│   └── models.py
├── README.md
└── requirements.txt
```

## Implementation

Here's how to implement a basic FastAPI application with a books endpoint:

1. First, create a `requirements.txt` file:

```
fastapi>=0.68.0
uvicorn>=0.15.0
```

2. Create the `app/models.py` file:

```python
from pydantic import BaseModel
from typing import Optional, List

class Book(BaseModel):
    id: int
    title: str
    author: str
    description: Optional[str] = None
    price: float
    in_stock: bool = True
```

3. Create the `app/main.py` file:

```python
from fastapi import FastAPI, HTTPException
from typing import List
from .models import Book

app = FastAPI(title="Books API")

# Sample data
books = [
    Book(id=1, title="The Great Gatsby", author="F. Scott Fitzgerald", price=12.99),
    Book(id=2, title="1984", author="George Orwell", description="A dystopian novel", price=10.99),
    Book(id=3, title="To Kill a Mockingbird", author="Harper Lee", price=15.99),
]

@app.get("/")
def read_root():
    return {"message": "Welcome to the Books API"}

@app.get("/books", response_model=List[Book])
def get_books():
    return books

@app.get("/books/{book_id}", response_model=Book)
def get_book(book_id: int):
    for book in books:
        if book.id == book_id:
            return book
    raise HTTPException(status_code=404, detail="Book not found")
```

## Running the API

```bash
# Start the server
uvicorn app.main:app --reload
```

Visit `http://localhost:8000/docs` in your browser to see the Swagger documentation and interact with your API.

## API Endpoints

- `GET /books`: Retrieve a list of all books
- `GET /books/{book_id}`: Retrieve a specific book by ID

## Next Steps

Consider adding:
- POST endpoint to create new books
- PUT endpoint to update existing books
- DELETE endpoint to remove books
- Database integration instead of in-memory storage

## License

This project is licensed under the MIT License - see the LICENSE file for details.

### github actions - terraform workflow


### usage
```
export TF_VAR_cf_user_password=your_password
terraform init
terraform plan --out=plan.out
terraform apply "plan.out"
```