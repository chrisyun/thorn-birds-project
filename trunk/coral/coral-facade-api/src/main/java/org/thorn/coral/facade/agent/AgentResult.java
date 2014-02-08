/*
 * @(#)AgentResult  1.0 2014-01-26
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.facade.agent;

import java.io.Serializable;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-26.
 * @version 1.0
 * @since 1.0
 */
public class AgentResult implements Serializable {

    private static final long serialVersionUID = 660975047501695308L;

    private boolean success;

    private String error;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    @Override
    public String toString() {
        return "AgentResult{" +
                "success=" + success +
                ", error='" + error + '\'' +
                '}';
    }
}
