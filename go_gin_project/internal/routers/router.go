package routers

import (
	"github.com/gin-gonic/gin"
	"go-gin-project/internal/handlers"
)

func GetRouter(router *gin.Engine) {
	v1 := router.Group("/v1")
	{
		v1.GET("/login", handlers.LoginEndpoint)
	}

}
