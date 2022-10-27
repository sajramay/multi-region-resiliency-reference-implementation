// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0
package app.tradematching.core.matching.exceptions;

public class TradePersistException extends Exception  {
    public TradePersistException(String info, Object...message)
    {
        super(info);
    }
    public TradePersistException(String info, Exception ex)
    {
        super(info, ex);
    }

}
