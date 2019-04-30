package tutorial

import (
	"fmt"
	"github.com/golang/protobuf/proto"
	"github.com/golang/protobuf/ptypes"
	"io/ioutil"
	"testing"
	"time"
)

const fname  = "addrbook"

func TestAddressBook(t *testing.T) {
	fmt.Println("start writing...")
	write(t)
	fmt.Println("write done...")

	time.Sleep(2*time.Second)

	fmt.Println("start reading...")
	read(t)
	fmt.Println("read done")
}

func write(t *testing.T)  {
	book := &AddressBook{
		People: []*Person{
			{
				Name: "A",
				Email: "a.com",
				Id: 1,
				Phones: []*Person_PhoneNumber{
					{
						Number: "123445",
						Type: Person_HOME,
					},
				},
				LastUpdated: ptypes.TimestampNow(),
			},
		},
	}

	// Write the new address book back to disk.
	out, err := proto.Marshal(book)
	if err != nil {
		t.Fatal("Failed to encode address book:", err)
	}
	if err := ioutil.WriteFile(fname, out, 0644); err != nil {
		t.Fatal("Failed to write address book:", err)
	}
}

func read(t *testing.T) {
	in, err := ioutil.ReadFile(fname)
	if err != nil {
		t.Fatal("Error reading file:", err)
	}
	book := &AddressBook{}
	if err := proto.Unmarshal(in, book); err != nil {
		t.Fatal("Failed to parse address book:", err)
	}

	fmt.Println(*book)
}