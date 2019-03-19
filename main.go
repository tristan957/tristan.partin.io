package main

import (
	"bytes"
	"html/template"
	"io/ioutil"
	"log"

	"git.sr.ht/~tristan957/tristan.partin.io/pw"
	"gopkg.in/yaml.v2"
)

var templates map[string]*template.Template

func main() {
	bs, err := ioutil.ReadFile("me.yml")
	if err != nil {
		log.Fatalln(err)
	}

	var info pw.Information
	yaml.Unmarshal(bs, &info)

	t, err := template.New("base").ParseGlob("templates/*.template.html")
	if err != nil {
		log.Fatalln(err)
	}

	buffer := new(bytes.Buffer)

	err = t.Execute(buffer, info)
	if err != nil {
		log.Fatalln(err)
	}

	err = ioutil.WriteFile("public/index.html", buffer.Bytes(), 0755)
	if err != nil {
		log.Fatalln(err)
	}
}
