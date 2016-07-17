/*
 * This is the source code of Telegram for iOS v. 1.1
 * It is licensed under GNU GPL v. 2 or later.
 * You should have received a copy of the license in this archive (see LICENSE).
 *
 * Copyright Peter Iakovlev, 2013.
 */

#ifndef Telegraph_TLMetaField_h
#define Telegraph_TLMetaField_h

#include "TLMetaType.h"

#include <tr1/memory>

struct TLMetaField
{
    int32_t name;
    
    TLMetaTypeArgument type;
};

#endif
