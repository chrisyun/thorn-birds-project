package org.thorn.mypass.core;

public class NoSessionException extends Exception {

    public NoSessionException() {
        super("There is no session in cache!");
    }

}
