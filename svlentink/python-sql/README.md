# python-sql

usage:
```dockerfile
FROM svlentink/python-sql
COPY requirements.txt /
RUN pip install -r /requirements.txt
COPY $PWD /proj #your project
```

example config at `/proj/config.yml`:
```yaml
db:
  host: db.lent.ink
  user: testuser
  password: 5ecr37
  database: product
some: other value
and: another
```

importing in your code:
```python
#!/usr/bin/env python
usingMYSQLinsteadOfPOSTGRES = True
from dblib import db_sql
```
