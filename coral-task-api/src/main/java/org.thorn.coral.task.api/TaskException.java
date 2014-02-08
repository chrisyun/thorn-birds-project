/*
 * @(#)TaskException  1.0 2014-01-22
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.task.api;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-22.
 * @version 1.0
 * @since 1.0
 */
public class TaskException extends Exception {

    public TaskException() {
    }

    public TaskException(String message) {
        super(message);
    }

    public TaskException(String message, Throwable cause) {
        super(message, cause);
    }

    public TaskException(Throwable cause) {
        super(cause);
    }
}
