package org.thorn.spass.exception;

/**
 * @Author: yfchenyun
 * @Since: 13-8-29 下午4:47
 * @Version: 1.0
 */
public class SPassException extends Exception {

    public SPassException() {
    }

    public SPassException(String message) {
        super(message);
    }

    public SPassException(String message, Throwable cause) {
        super(message, cause);
    }

    public SPassException(Throwable cause) {
        super(cause);
    }
}
