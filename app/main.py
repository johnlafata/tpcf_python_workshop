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
    return {"message": "Welcome to this Amazing Books API on 2/4/26 in the afternoon!"}

@app.get("/books", response_model=List[Book])
def get_books():
    return books

@app.get("/books/{book_id}", response_model=Book)
def get_book(book_id: int):
    for book in books:
        if book.id == book_id:
            return book
    raise HTTPException(status_code=404, detail="Book not found")

@app.post("/books", response_model=Book, status_code=201)
def create_book(book: Book):
    """
    Create a new book and add it to the collection.
    
    - **id**: Unique identifier for the book
    - **title**: Book title
    - **author**: Book author
    - **description**: Optional book description
    - **price**: Book price
    - **in_stock**: Whether the book is in stock (defaults to True)
    """
    # Check if book with same ID already exists
    for existing_book in books:
        if existing_book.id == book.id:
            raise HTTPException(status_code=400, detail="Book with this ID already exists")
    
    books.append(book)
    return book
