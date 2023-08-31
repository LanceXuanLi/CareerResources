package handlers

import "github.com/gin-gonic/gin"

func LoginEndpoint(c *gin.Context) {
	c.JSON(200, "login on")
}
