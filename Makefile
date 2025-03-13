SRC=$(PWD)
BIN_ROOT=$(PWD)/.bin
export LOCAL_DIR=$(PWD)
SIM_BIN_NAME=simulator
SIM_CMD=./$(SIM_BIN_NAME)
all: init bin
init:
	# only run once !!
	cd cmd/simulator && go mod init simulator
	cd cmd/simulator && go mod tidy
bin:
	mkdir -p $(BIN_ROOT)
	cd cmd/simulator && go build -o $(BIN_ROOT)/$(SIM_BIN_NAME) .
	cp $(BIN_ROOT)/$(SIM_BIN_NAME) $(SRC)
bin-del:
	rm -f $(SRC)/$(SIM_BIN_NAME)
test:
	cd cmd/simulator && go test -v --local_path=$(LOCAL_DIR) .
run-docker:
	docker run --rm -it -p 8000:8000 eu.gcr.io/simhospital-images/simhospital:latest health/simulator
run-sim-h:
	$(SIM_CMD) -h
run-sim:
	$(SIM_CMD) -log_level=DEBUG
