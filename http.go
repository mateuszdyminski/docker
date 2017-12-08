package main

import (
    "fmt"
    "net/http"
    "log"
	"io/ioutil"
	"github.com/BurntSushi/toml"
	"flag"
)

var (
	configPath = flag.String("config", "config/config.toml", "path to http configuration")
)

func hello(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello Nokia Wroclaw!")
}

func main() {
	conf, err := LoadCfg()
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}

	http.HandleFunc("/hello", hello)

	http.Handle("/", http.FileServer(http.Dir(conf.Statics)))

    err = http.ListenAndServe(conf.Host, nil)
    if err != nil {
        log.Fatal("ListenAndServe: ", err)
    }
}

func LoadCfg() (*Config, error) {
	flag.Parse()

	bytes, err := ioutil.ReadFile(*configPath)
	if err != nil {
		return nil, err
	}

	conf := Config{}
	if err := toml.Unmarshal(bytes, &conf); err != nil {
		return nil, err
    }
    
    return &conf, nil
}

type Config struct {
	Host    string
	Statics string
}
