# Quies 0 spec

## General ideas (uncategorized)
   * The meta content needs to be reasonably usable and mix with existing code, but not like C++ templates
   * no objects
   * functions are pure by default unless marked with an effect
   * values are constant by default unless marked mutable
   * codegen is customizable to more than just binary
      * e.g. you should be able to reflectively spit out documentation and other helper files straight from the source in a programmable way
   * lambdas
      * not sure what to do about closures. they're sort of just callable structs?
   * explicit alignment, byte order etc
      * not sure what to do about function calling conventions, probably explicit too
   * all function arguments explicitly named always
      * what about lambdas?
   * opinionated:
      * empty space at the end of the line is an error
      * mixed indentation is an error
      * lack of newline at the end of file is an error
      * inconsisted naming within one module is a warning


## Spec draft

1. Overall arch
  * The compiler compiles modules
  * A module is divided into two sections:
    * preamble
    * content

1. The preamble section

   This section can contain:
     * module includes
     * language behaviour flags
     * meta (compile-time) content

   1. Hardware capabilities list

      It's possible to define custom capabilities that are then checked. The base library provides
    certain capabilities that are predefined.
     Those capabilities can be listed as supported from the platform side, and as required from the code side. They form a contract between the code author and the platform.

     1. Port specification
        The code might list necessary hardware specification. 
     1. Floating point support
        The code can reserve to be only compiled for hardware with hardware float support.
     1. Alignment requirements

   1. Defaults override

     1. Alignment requirements change

        Depending on the intended use for the program, it might be necessary to either relax the alignment rules for tight packing, or make them more stringent. This section allows per-module default alignment settings.
  
1. The content section

  1. Types
    1. Type aliases
    1. Type definitions
  1. Values
    1. Constants
      Constants are values that don't change, and can be initialized statically.
      Examples of constants: functions, pi etc.
      1. Functions
    1. One-time variables
      One time variables are values that are initialized once, but can't change afterwards.
    1. Variables
      Variables

1. The base library
  1. Base preamble
  1. Base types
  1. Base values





