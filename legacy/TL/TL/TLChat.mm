#import "TLChat.h"

#import "../NSInputStream+TL.h"
#import "../NSOutputStream+TL.h"


@implementation TLChat


- (int32_t)TLconstructorSignature
{
    TGLog(@"constructorSignature is not implemented for base type");
    return 0;
}

- (int32_t)TLconstructorName
{
    TGLog(@"constructorName is not implemented for base type");
    return 0;
}

- (id<TLObject>)TLbuildFromMetaObject:(std::tr1::shared_ptr<TLMetaObject>)__unused metaObject
{
    TGLog(@"TLbuildFromMetaObject is not implemented for base type");
    return nil;
}

- (void)TLfillFieldsWithValues:(std::map<int32_t, TLConstructedValue> *)__unused values
{
    TGLog(@"TLfillFieldsWithValues is not implemented for base type");
}


@end

@implementation TLChat$chatEmpty : TLChat


- (int32_t)TLconstructorSignature
{
    return (int32_t)0x9ba2d800;
}

- (int32_t)TLconstructorName
{
    return (int32_t)0xaae285ba;
}

- (id<TLObject>)TLbuildFromMetaObject:(std::tr1::shared_ptr<TLMetaObject>)metaObject
{
    TLChat$chatEmpty *object = [[TLChat$chatEmpty alloc] init];
    object.n_id = metaObject->getInt32((int32_t)0x7a5601fb);
    return object;
}

- (void)TLfillFieldsWithValues:(std::map<int32_t, TLConstructedValue> *)values
{
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypePrimitiveInt32;
        value.primitive.int32Value = self.n_id;
        values->insert(std::pair<int32_t, TLConstructedValue>((int32_t)0x7a5601fb, value));
    }
}


@end

@implementation TLChat$channelForbidden : TLChat


- (int32_t)TLconstructorSignature
{
    return (int32_t)0x2d85832c;
}

- (int32_t)TLconstructorName
{
    return (int32_t)0x731ea8a0;
}

- (id<TLObject>)TLbuildFromMetaObject:(std::tr1::shared_ptr<TLMetaObject>)metaObject
{
    TLChat$channelForbidden *object = [[TLChat$channelForbidden alloc] init];
    object.n_id = metaObject->getInt32((int32_t)0x7a5601fb);
    object.access_hash = metaObject->getInt64((int32_t)0x8f305224);
    object.title = metaObject->getString((int32_t)0xcdebf414);
    return object;
}

- (void)TLfillFieldsWithValues:(std::map<int32_t, TLConstructedValue> *)values
{
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypePrimitiveInt32;
        value.primitive.int32Value = self.n_id;
        values->insert(std::pair<int32_t, TLConstructedValue>((int32_t)0x7a5601fb, value));
    }
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypePrimitiveInt64;
        value.primitive.int64Value = self.access_hash;
        values->insert(std::pair<int32_t, TLConstructedValue>((int32_t)0x8f305224, value));
    }
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypeString;
        value.nativeObject = self.title;
        values->insert(std::pair<int32_t, TLConstructedValue>((int32_t)0xcdebf414, value));
    }
}


@end

@implementation TLChat$chatForbidden : TLChat


- (int32_t)TLconstructorSignature
{
    return (int32_t)0x7328bdb;
}

- (int32_t)TLconstructorName
{
    return (int32_t)0x5ec2aeb5;
}

- (id<TLObject>)TLbuildFromMetaObject:(std::tr1::shared_ptr<TLMetaObject>)metaObject
{
    TLChat$chatForbidden *object = [[TLChat$chatForbidden alloc] init];
    object.n_id = metaObject->getInt32((int32_t)0x7a5601fb);
    object.title = metaObject->getString((int32_t)0xcdebf414);
    return object;
}

- (void)TLfillFieldsWithValues:(std::map<int32_t, TLConstructedValue> *)values
{
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypePrimitiveInt32;
        value.primitive.int32Value = self.n_id;
        values->insert(std::pair<int32_t, TLConstructedValue>((int32_t)0x7a5601fb, value));
    }
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypeString;
        value.nativeObject = self.title;
        values->insert(std::pair<int32_t, TLConstructedValue>((int32_t)0xcdebf414, value));
    }
}


@end

