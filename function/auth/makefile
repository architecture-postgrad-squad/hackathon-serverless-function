VENV_NAME = venv
PYTHON = python3
PIP = $(VENV_NAME)/bin/pip
PIP_COMPILE = $(VENV_NAME)/bin/pip-compile
ACTIVATE = $(VENV_NAME)/bin/activate

setup:
	@echo "Setting up virtual environment..."
	$(PYTHON) -m venv $(VENV_NAME)
	. $(ACTIVATE) 
	${PIP} install --upgrade pip setuptools pip-tools
	${PIP_COMPILE} --generate-hashes --output-file=requirements.txt requirements.in 
	
	@echo "Installing dependencies..."
	$(PIP) install -r requirements.txt

zip-dependencies:
	@echo "Zipping up virtual environment dependencies..."
	mkdir python
	cp -r venv/lib/python3.*/site-packages/* python/
	zip -r9 ../lambda-dependencies.zip python/

zip-function:
	@echo "Zipping lambda authentication function..."
	zip ../function.zip app.py

format:
	@echo "Formatting app.py..."
	${PYTHON} -m black app.py

clean:
	@echo "Removing virtual environment..."
	rm -r /lambdafunc 
	rm -r /python
	rm -r /venv
