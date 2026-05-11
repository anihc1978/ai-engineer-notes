# Cheat Sheet: Python Modern Features

> **AI Engineer Notes** — Part of the `ai-engineer-notes` collection. Covers four essential modern Python patterns used in data engineering, AI pipelines, and production code: list/dict comprehensions, type hints, dataclasses, and Pydantic v2 basics.

---

## 1. List & Dict Comprehensions

Comprehensions are concise, readable ways to build collections in a single expression.

### List Comprehension

```python
# Syntax: [expression for item in iterable if condition]
squares = [x**2 for x in range(10) if x % 2 == 0]
# [0, 4, 16, 36, 64]
```

### Dict Comprehension

```python
# Syntax: {key: value for item in iterable if condition}
word_len = {w: len(w) for w in ["apple", "banana", "cherry"]}
# {'apple': 5, 'banana': 6, 'cherry': 6}

# Invert a dict
original = {"a": 1, "b": 2, "c": 3}
inverted = {v: k for k, v in original.items()}
# {1: 'a', 2: 'b', 3: 'c'}
```

### Set Comprehension

```python
unique_lengths = {len(w) for w in ["apple", "banana", "cherry", "date"]}
# {4, 5, 6}
```

### Generator Expression (lazy, memory-efficient)

```python
total = sum(x**2 for x in range(1_000_000))  # no list built in memory
```

### Nested Comprehension (flatten a matrix)

```python
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
flat = [val for row in matrix for val in row]
# [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

| Pattern | Syntax | Use case |
|---------|--------|----------|
| List | `[expr for x in it]` | Transform / filter sequences |
| Dict | `{k: v for x in it}` | Build lookup tables |
| Set | `{expr for x in it}` | Unique values |
| Generator | `(expr for x in it)` | Lazy evaluation, large data |

---

## 2. Type Hints

Type hints (PEP 484/526/604) let you annotate variables and function signatures without affecting runtime behavior. They power IDEs, linters (`mypy`), and Pydantic.

### Basic Annotations

```python
from __future__ import annotations  # enables string-forward refs
from typing import Optional, Callable, TypeVar, Generic

def add(x: int, y: int) -> int:
    return x + y

def greet(name: str, greeting: str = "Hello") -> str:
    return f"{greeting}, {name}!"
```

### Optional / Union

```python
def parse_int(value: str) -> Optional[int]:   # same as int | None
    try:
        return int(value)
    except ValueError:
        return None

# Python 3.10+ shorthand (PEP 604)
def stringify(value: int | float | None) -> str:
    return "N/A" if value is None else str(value)
```

### Collections (Python 3.9+)

```python
def process(items: list[int]) -> dict[str, int]:
    return {str(i): i**2 for i in items}

def minmax(data: list[float]) -> tuple[float, float]:
    return min(data), max(data)
```

### Callable

```python
from typing import Callable

def apply(func: Callable[[int], int], values: list[int]) -> list[int]:
    return [func(v) for v in values]
```

### Generic Class

```python
from typing import TypeVar, Generic

T = TypeVar("T")

class Stack(Generic[T]):
    def __init__(self) -> None:
        self._items: list[T] = []
    def push(self, item: T) -> None:
        self._items.append(item)
    def pop(self) -> T:
        return self._items.pop()
```

| Hint | Meaning |
|------|---------|
| `int | None` | Optional integer (3.10+) |
| `list[str]` | List of strings (3.9+) |
| `dict[str, int]` | String-keyed int dict |
| `tuple[float, float]` | Fixed-length tuple |
| `Callable[[A], B]` | Function A→B |
| `Generic[T]` | Parameterised class |

---

## 3. Dataclasses

`@dataclass` (PEP 557, Python 3.7+) auto-generates `__init__`, `__repr__`, `__eq__`, and optionally ordering and hashing.

### Basic Usage

```python
from dataclasses import dataclass, field
from typing import ClassVar

@dataclass
class Point:
    x: float
    y: float

    def distance_from_origin(self) -> float:
        return (self.x**2 + self.y**2) ** 0.5

p = Point(3.0, 4.0)
print(p)                          # Point(x=3.0, y=4.0)
print(p.distance_from_origin())   # 5.0
```

### Field Defaults and Metadata

```python
@dataclass
class Product:
    name: str
    price: float
    tags: list[str] = field(default_factory=list)  # safe mutable default
    _id_counter: ClassVar[int] = 0                  # class-level, not a field
```

### Ordering

```python
@dataclass(order=True)
class Version:
    major: int
    minor: int
    patch: int

print(Version(1, 9, 0) < Version(2, 0, 0))  # True
```

### Frozen (Immutable & Hashable)

```python
@dataclass(frozen=True)
class Coordinate:
    lat: float
    lon: float

coords = {Coordinate(-31.95, 115.86): "Perth"}  # usable as dict key
```

### Serialisation

```python
from dataclasses import asdict, astuple

@dataclass
class RGB:
    r: int; g: int; b: int

colour = RGB(255, 128, 0)
print(asdict(colour))   # {'r': 255, 'g': 128, 'b': 0}
print(astuple(colour))  # (255, 128, 0)
```

| Decorator option | Effect |
|-----------------|--------|
| `eq=True` (default) | Generates `__eq__` |
| `order=True` | Generates `<`, `>`, `<=`, `>=` |
| `frozen=True` | Immutable + hashable |
| `slots=True` (3.10+) | Uses `__slots__` for lower memory |
| `field(default_factory=)` | Safe mutable default |

---

## 4. Pydantic Basics (v2)

Pydantic provides runtime data validation, serialisation, and JSON schema generation using type hints. It is the backbone of FastAPI, LangChain, and many AI frameworks.

### BaseModel

```python
from pydantic import BaseModel
from typing import Optional

class User(BaseModel):
    id: int
    name: str
    email: str
    age: Optional[int] = None

user = User(id=1, name="Eduardo", email="e@example.com", age=45)
print(user.model_dump())
# {'id': 1, 'name': 'Eduardo', 'email': 'e@example.com', 'age': 45}

json_str = user.model_dump_json()
user2   = User.model_validate_json(json_str)
```

### Field Constraints

```python
from pydantic import BaseModel, Field

class Product(BaseModel):
    name:  str   = Field(min_length=1, max_length=100)
    price: float = Field(gt=0, description="Price in AUD")
    sku:   str   = Field(pattern=r"^[A-Z]{3}-\d{4}$")
    tags:  list[str] = Field(default_factory=list)
```

### Custom Validators

```python
from pydantic import BaseModel, field_validator, model_validator

class Order(BaseModel):
    quantity:   int
    unit_price: float
    total:      float = 0.0

    @field_validator("quantity")
    @classmethod
    def qty_must_be_positive(cls, v: int) -> int:
        if v <= 0:
            raise ValueError("quantity must be > 0")
        return v

    @model_validator(mode="after")
    def set_total(self) -> "Order":
        self.total = self.quantity * self.unit_price
        return self
```

### Enums

```python
from enum import Enum
from pydantic import BaseModel

class Priority(str, Enum):
    LOW    = "low"
    MEDIUM = "medium"
    HIGH   = "high"

class Task(BaseModel):
    title:    str
    priority: Priority = Priority.MEDIUM
```

### ValidationError Handling

```python
from pydantic import ValidationError

try:
    bad = User(id="not-an-int", name="", email="bad")
except ValidationError as exc:
    print(exc.error_count(), "errors")
    for err in exc.errors():
        print(err["loc"], err["msg"])
```

### Nested Models

```python
class Address(BaseModel):
    street:   str
    city:     str
    postcode: str

class Customer(BaseModel):
    name:    str
    address: Address   # validated automatically on construction
```

| Feature | API |
|---------|-----|
| Dump to dict | `model.model_dump()` |
| Dump to JSON | `model.model_dump_json()` |
| Load from dict | `Model.model_validate(d)` |
| Load from JSON | `Model.model_validate_json(s)` |
| JSON schema | `Model.model_json_schema()` |
| Field constraint | `Field(gt=0, min_length=1, …)` |
| Field validator | `@field_validator("field")` |
| Model validator | `@model_validator(mode="after")` |

---

## Quick-Reference Summary

| Feature | When to use |
|---------|-------------|
| **List comprehension** | Transform / filter sequences in one readable line |
| **Dict comprehension** | Build or invert mappings concisely |
| **Generator expression** | Lazy iteration over large or infinite datasets |
| **Type hints** | IDE support, `mypy` checking, Pydantic / FastAPI integration |
| **Dataclass** | Simple internal data containers; auto-generated boilerplate |
| **Pydantic BaseModel** | External data (APIs, configs, DB rows) requiring validation |

> **Rule of thumb:** use `@dataclass` for internal, trusted data structures; use Pydantic `BaseModel` for any data crossing a trust boundary (HTTP, files, environment variables).
