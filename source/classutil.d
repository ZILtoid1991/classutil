module classutil;
/** 
 * Checks if the object instance have implemented the given interface or not.
 * Intended for avoiding typecasting incidents.
 * Params:
 *   o = The object instance to be tested.
 * Template params:
 *   I = The interface type to check for.
 * Returns: True if interface is implemented in the object instance, false otherwise.
 */
public bool isInterface(I)(Object o) @safe nothrow {
    for (TypeInfo_Class crnt = o.classinfo ; crnt !is null ; crnt = crnt.base) {
        foreach (Interface key; crnt.interfaces) {
            if (key.classinfo == I.classinfo)
                return true;
        }
    }
    return false;
}
/** 
 * Check if the object instance is of a certain class, inherited from it, or not.
 * Intended for avoiding typecasting incidents.
 * Params:
 *   o = The object instance to be tested.
 * Template params:
 *   C = The class type to check for.
 * Returns: True if the class is of a given type or have inherited from it, false otherwise.
 */
public bool isClass(C)(Object o) @safe nothrow {
    import std.string;
    for (TypeInfo_Class crnt = o.classinfo ; crnt !is null ; crnt = crnt.base) {
        if (crnt == C.classinfo)
            return true;
    }
    return false;
}
/** 
 * Check if the type that has a static classinfo property is implemented by the object instance or not.
 * Intended for avoiding typecasting incidents.
 * Params:
 *   o = The object instance to be tested.
 * Template params:
 *   T = The class or interface type to check for.
 * Returns: True if the class is of a given type or have inherited from it, false otherwise.
 */
public bool isImplemented(T)(Object o) @safe nothrow {
    for (TypeInfo_Class crnt = o.classinfo ; crnt !is null ; crnt = crnt.base) {
        if (crnt == T.classinfo)
            return true;
        foreach (Interface key; crnt.interfaces) {
            if (key.classinfo == T.classinfo)
                return true;
        }
    }
    return false;
}
unittest {
    interface I0 {}
    interface I1 {}
    interface I2 {}
    class C0 : I0 {
        this() {}
    }
    class C1 : C0, I1 {
        this() {}
    }
    Object test0 = new C0();
    Object test1 = new C1();
    assert(isInterface!I0(test0));
    assert(!isInterface!I1(test0));
    assert(!isInterface!I2(test0));
    assert(isInterface!I0(test1));
    assert(isInterface!I1(test1));
    assert(!isInterface!I2(test1));
    assert(isClass!C0(test0));
    assert(isClass!C0(test1));
    assert(!isClass!C1(test0));
    assert(isClass!C1(test1));
    assert(isImplemented!C0(test0));
    assert(!isImplemented!C1(test0));
}