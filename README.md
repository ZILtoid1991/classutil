# classutil
Class/interface type checking utility for D.

# Example

It can check interface types of any class instance that has TypeInfo (unfortunately, you'll have to use other means for C++ classes) to avoid unsafe typecasting, and to direct code to do other things.

```d
public void someFunction(Object o) {
    if (isInterface!InterfaceOne(o)) {
        InterfaceOne foo = cast(InterfaceOne)o;
        [...]
    } else if (isInterface!InterfaceTwo(o)) {
        InterfaceTwo foo = cast(InterfaceTwo)o;
        [...]
    }
}
```

Same with classes:

```d
public void someFunction(Object o) {
    if (isClass!SomeClass(o)) {
        SomeClass foo = cast(SomeClass)o;
        foo.functionExclusiveToSomeClass();
    }
}
```

Other alternatives include:
* The typeid expression, but this only works during compile time.
* Giving the class a function to check its type, but this becomes hard to maintain in bigger projects, and might not be universal.
* Manually checking the classinfo of each instance.

# Potential applications

* Scripting languages binding to D class member functions in one way or another.
* Having to differentiate the multiple children of the same class type.
* Casting types safely in general.