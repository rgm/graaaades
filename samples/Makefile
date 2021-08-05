SQLITE3_FILES = $(wildcard *.sqlite3)
DDL_FILES = $(SQLITE3_FILES:%.sqlite3=%.sql)

all: $(DDL_FILES)

# dump ddl for inspection / diffs
%.sql: %.sqlite3
	sqlite3 $< .dump > $@
