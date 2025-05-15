from pydantic import BaseModel
from typing import Optional, List

class Book(BaseModel):
    id: int
    title: str
    author: str
    description: Optional[str] = None
    price: float
    in_stock: bool = True