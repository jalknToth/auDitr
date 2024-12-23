## Installation

1. **Clone the repository:**
```bash
git clone https://github.com/jalknToth/auDitr.git
```

2. **Run the setup script:**
```bash
chmod +x run.sh
./run.sh
```
The script will create:
- 🔧 Persons urls
- 🔧 Persons models
- 🔧 Persons views
- 🔧 Auditor views
- 🔧 Auditor urls
- 🔧 Auditor settings
- 🔧 Templates
- 🔧 Admin
- 🔧 Admin User: input username, email and password

3. **Open admin**
Run inside auditor
```
python3 manage.py runserver
```
To create a new admin user run
```
python3 manage.py createsuperuser
```
Then open http://127.0.0.1:8000/admin

<table>
  <tr>
    <td><img src="screenshots/login.png" alt="login" width="200px"></td>
    <td><img src="screenshots/admin.png" alt="admin" width="200px"></td>
  </tr>
</table>

