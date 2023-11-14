package main

import (
	"context"
	"fmt"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
)

type MyEvent struct {
	Name string `json:"name"`
}

func HandleRequest(ctx context.Context, event *MyEvent) (*string, error) {
	fmt.Printf("ctx %v and event:%v\n", ctx, event)
	start := time.Now()

	if event == nil {
		return nil, fmt.Errorf("received nil event")
	}
	message := fmt.Sprintf("Hello %s!", event.Name)
	fmt.Printf("message %v\n", message)
	fmt.Println("Total Execution time ", time.Since(start))
	return &message, nil
}

func main() {
	lambda.Start(HandleRequest)
	// HandleRequest(context.TODO(), &MyEvent{Name: "Narendra"})
}
