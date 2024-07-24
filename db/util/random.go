package util

import (
	"math/rand"
	"strings"
	"time"

	
)

const alphabet = "abcdefghijklmnopqrstuvwxyz"

func init(){
	rand.Seed(time.Now().UnixNano())
}

// randomInt generates a random integer between min and max

func randomInt(min,max int64) int64{
	return min +rand.Int63n(max-min+1)
}

// Random String generates a random string of length n

func RandomString(n int) string {
	var sb strings.Builder
	k:= len(alphabet)

	for i :=0;i<n;i++ {
		c := alphabet[rand.Intn(k)]
		sb.WriteByte(c)
	}
	return sb.String()
}

// RandomOwner generates a random owner name

func RandomOwner() string{
	return RandomString(6)
}

// Random Money generates a random ammount of money

func RandomMoney() int64{
	return randomInt(0, 1000)
}

// RandomCurrency generates a random currency code

func RandomCurrency() string{
	currencies := []string{"EUR", "RS"," USD", "CAD"}
	n := len(currencies)
	return currencies[rand.Intn(n)]
}