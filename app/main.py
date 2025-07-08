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
    return {"message": "Welcome to the test deployment of the Books API"}

@app.get("/books", response_model=List[Book])
def get_books():
    return books

@app.get("/books/{book_id}", response_model=Book)
def get_book(book_id: int):
    for book in books:
        if book.id == book_id:
            return book
    raise HTTPException(status_code=404, detail="Book not found")
