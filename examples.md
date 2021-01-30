
# Equivalent C and C++ constructs

## Macros

C:

    #define PIN_B1 21

Quies:

    static { hardware {
        gpio {
            bank "B" {
                port 1 = 21
            }
        }
    }}


---

C:

    #define MAX_ELEMENTS = 100

Quies:
    
    static {
        MAX_ELEMENTS = 100
    }


---

C++

    Serial serial; // global variable

Quies:

    onetime {
        serial = hardware.serial.Serial1
    }

## Function definitions

C:

    int foo(int param) {
        return param + 42;
    }

    foo(43);

Quies:

    foo = function { 
        stdcall
    } {
        param: int32      // fixed size types
    } {
        return param + 42 // infix operator
    }

    foo(param: 43)

