<?php

// configuration

$config = array(
	// server
	"host" => "localhost",
	"path" => "api/poi/",
	"service_endpoint" => "http://localhost/api/poi/",

	// database
	"database" => "poi-db",
	"collection" => "poi_set21",
	"db_host" => "127.0.0.1:27017",
	"db_user" => "poi-db-user",
	"db_password" => "poi-db-password",
	
	// poi query
	"default_limit" => 25,
	"max_limit" => 100
	
	// validation
	"schema" => "schema/poi-schema.json",
	"schema_url" => "http://example.com/poi-v1"
);


?>