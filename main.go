package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	"github.com/go-sql-driver/mysql"
	"github.com/labstack/echo/v4"
	"github.com/rs/cors"
)

var db *sql.DB

type Login struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

func connectDB() *sql.DB {
	// Capture connection properties.
	cfg := mysql.Config{
		User:                 "root",
		Passwd:               "root",
		Net:                  "tcp",
		Addr:                 "localhost:3306",
		DBName:               "userdb",
		AllowNativePasswords: true,
	}
	// Get a database handle.
	var err error
	db, err = sql.Open("mysql", cfg.FormatDSN())
	if err != nil {
		log.Fatal(err)
	}

	pingErr := db.Ping()
	if pingErr != nil {
		log.Fatal(pingErr)
	}
	fmt.Println("Connected!")
	// Now you can execute SQL queries using the 'db' object
	return db
}

func main() {

	e := echo.New()
	db := connectDB()

	e.Use(echo.WrapMiddleware(cors.Default().Handler)) // Wrap cors.Default().Handler with echo.WrapMiddleware

	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!")
	})

	e.POST("/login", func(c echo.Context) error {
		var data map[string]string
		fmt.Println("Hello")

		if err := c.Bind(&data); err != nil {
			return err
		}
		rows, err := db.Query("SELECT email, password FROM users WHERE email = ? AND password = ?", data["email"], data["password"])
		if err != nil {
			panic(err.Error())
		}
		defer rows.Close()

		// Process the query results
		rowCount := 0

		for rows.Next() {
			var username string
			var password string
			if err := rows.Scan(&username, &password); err != nil {
				panic(err.Error())
			}
			rowCount++
			fmt.Printf("%s  %s\n", username, password)
			print("Login Successful :)")
		}

		if rowCount == 0 {
			return c.String(http.StatusNotFound, "user not found")
		}

		return c.String(http.StatusOK, "Data Sent Successfully")
	})

	e.POST("/register", func(c echo.Context) error {
		db := connectDB()
		var data Login
		if err := c.Bind(&data); err != nil {
			return err
		}
		fmt.Println(data)

		_, _ = db.Exec("INSERT INTO users (email,password) VALUES ( ?, ?)",
			 data.Email, data.Password)

		return c.String(http.StatusOK, "Data inserted successfully")
	})

	e.Logger.Fatal(e.Start(":8080"))
}