package main

import (
	"github.com/gin-gonic/gin"
	"go-gin-project/internal/routers"
)

func main() {
	r := gin.Default()
	routers.GetRouter(r)
	err := r.Run(":3333")
	if err != nil {
		panic("Run gin error")
	}
}
