//! Simple logger that logs either to stderr or to a file, using `env_logger`
//! filter syntax. Amusingly, there's no crates.io crate that can do this and
//! only this.

use std::{
    fs::File,
    io::{BufWriter, Write},
};

use env_logger::filter::{Builder, Filter};
use log::{Log, Metadata, Record};
use parking_lot::Mutex;

pub(crate) struct Logger {
    filter: Filter,
    file: Option<Mutex<BufWriter<File>>>,
}

impl Logger {
    pub(crate) fn new(log_file: Option<File>, filter: Option<&str>) -> Logger {
        let filter = {
            let mut builder = Builder::new();
            if let Some(filter) = filter {
                builder.parse(filter);
            }
            builder.build()
        };

        let file = log_file.map(|it| Mutex::new(BufWriter::new(it)));

        Logger { filter, file }
    }

    pub(crate) fn install(self) {
        let max_level = self.filter.filter();
        let _ = log::set_boxed_logger(Box::new(self)).map(|()| log::set_max_level(max_level));
    }
}

impl Log for Logger {
    fn enabled(&self, metadata: &Metadata) -> bool {
        self.filter.enabled(metadata)
    }

    fn log(&self, record: &Record) {
        if !self.filter.matches(record) {
            return;
        }
        match &self.file {
            Some(w) => {
                let _ = writeln!(
                    w.lock(),
                    "[{} {}] {}",
                    record.level(),
                    record.module_path().unwrap_or_default(),
                    record.args(),
                );
            }
            None => eprintln!(
                "[{} {}] {}",
                record.level(),
                record.module_path().unwrap_or_default(),
                record.args(),
            ),
        }
    }

    fn flush(&self) {
        if let Some(w) = &self.file {
            let _ = w.lock().flush();
        }
    }
}
