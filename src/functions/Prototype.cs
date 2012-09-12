#region License

// 
// Copyright (c) 2012, Ian Davis
// 
// Dual-licensed under the Apache License, Version 2.0, and the Microsoft Public License (Ms-PL).
// See the file LICENSE.txt for details.
// 

#endregion

namespace Archetype
{
    using System;
    using System.Dynamic;
    
    public delegate bool TryBinaryOperationMissing( BinaryOperationBinder binder, object arg, out object result );

    public delegate bool TryConvertMissing( ConvertBinder binder, out object result );

    public delegate bool TryCreateInstanceMissing( CreateInstanceBinder binder, object[] args, out object result );

    public delegate bool TryDeleteIndexMissing( DeleteIndexBinder binder, object[] indexes );

    public delegate bool TryDeleteMemberMissing( DeleteMemberBinder binder );

    public delegate bool TryGetIndexMissing( GetIndexBinder binder, object[] indexes, out object result );

    public delegate bool TryGetMemberMissing( GetMemberBinder binder, out object result );

    public delegate bool TryInvokeMemberMissing( InvokeMemberBinder binder, object[] args, out object result );

    public delegate bool TryInvokeMissing( InvokeBinder binder, object[] args, out object result );

    public delegate bool TrySetIndexMissing( SetIndexBinder binder, object[] indexes, object value );

    public delegate bool TrySetMemberMissing( SetMemberBinder binder, object value );

    public delegate bool TryUnaryOperationMissing( UnaryOperationBinder binder, out object result );

    
    public class PrototypalObject : DynamicObject
    {
        public PrototypalObject()
          :this(null)
        {
        }

        public PrototypalObject(DynamicObject prototype)
        {
            Prototype = prototype;
        }

        public DynamicObject Prototype { get; set; }
        public virtual TryBinaryOperationMissing TryBinaryOperationMissing { get; set; }
        public virtual TryConvertMissing TryConvertMissing { get; set; }
        public virtual TryCreateInstanceMissing TryCreateInstanceMissing { get; set; }
        public virtual TryDeleteIndexMissing TryDeleteIndexMissing { get; set; }
        public virtual TryDeleteMemberMissing TryDeleteMemberMissing { get; set; }
        public virtual TryGetIndexMissing TryGetIndexMissing { get; set; }
        public virtual TryGetMemberMissing TryGetMemberMissing { get; set; }
        public virtual TryInvokeMemberMissing TryInvokeMemberMissing { get; set; }
        public virtual TryInvokeMissing TryInvokeMissing { get; set; }
        public virtual TrySetIndexMissing TrySetIndexMissing { get; set; }
        public virtual TrySetMemberMissing TrySetMemberMissing { get; set; }
        public virtual TryUnaryOperationMissing TryUnaryOperationMissing { get; set; }

        public override bool TryBinaryOperation( BinaryOperationBinder binder, object arg, out object result )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TryBinaryOperation(binder, arg, out result))
                {
                    return true;
                }
            }
            if ( TryBinaryOperationMissing == null )
            {
                result = null;
                return false;
            }
            return TryBinaryOperationMissing( binder, arg, out result );
        }

        public override bool TryConvert( ConvertBinder binder, out object result )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TryConvert(binder, out result))
                {
                    return true;
                }
            }
            if ( TryConvertMissing == null )
            {
                result = null;
                return false;
            }
            return TryConvertMissing( binder, out result );
        }

        public override bool TryCreateInstance( CreateInstanceBinder binder, object[] args, out object result )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TryCreateInstance(binder, args, out result))
                {
                    return true;
                }
            }
            if ( TryCreateInstanceMissing == null )
            {
                result = null;
                return false;
            }
            return TryCreateInstanceMissing( binder, args, out result );
        }

        public override bool TryDeleteIndex( DeleteIndexBinder binder, object[] indexes )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TryDeleteIndex(binder, indexes))
                {
                    return true;
                }
            }
            if ( TryDeleteIndexMissing == null )
            {
                return true;
            }
            return TryDeleteIndexMissing( binder, indexes );
        }

        public override bool TryDeleteMember( DeleteMemberBinder binder )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TryDeleteMember(binder))
                {
                    return true;
                }
            }
            if ( TryDeleteMemberMissing == null )
            {
                return true;
            }
            return TryDeleteMemberMissing( binder );
        }

        public override bool TryGetIndex( GetIndexBinder binder, object[] indexes, out object result )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TryGetIndex(binder, indexes, out result))
                {
                    return true;
                }
            }
            if ( TryGetIndexMissing == null )
            {
                result = null;
                return false;
            }
            return TryGetIndexMissing( binder, indexes, out result );
        }

        public override bool TryGetMember( GetMemberBinder binder, out object result )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TryGetMember(binder, out result))
                {
                    return true;
                }
            }
            if ( TryGetMemberMissing == null )
            {
                result = null;
                return false;
            }
            return TryGetMemberMissing( binder, out result );
        }

        public override bool TryInvokeMember( InvokeMemberBinder binder, object[] args, out object result )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TryInvokeMember(binder, args, out result))
                {
                    return true;
                }
            }
            if ( TryInvokeMemberMissing == null )
            {
                result = null;
                return false;
            }
            return TryInvokeMemberMissing( binder, args, out result );
        }

        public override bool TryInvoke( InvokeBinder binder, object[] args, out object result )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TryInvoke(binder, args, out result))
                {
                    return true;
                }
            }
            if ( TryInvokeMissing == null )
            {
                result = null;
                return false;
            }
            return TryInvokeMissing( binder, args, out result );
        }

        public override bool TrySetIndex( SetIndexBinder binder, object[] indexes, object value )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TrySetIndex(binder, indexes, value))
                {
                    return true;
                }
            }
            if ( TrySetIndexMissing == null )
            {
                return false;
            }
            return TrySetIndexMissing( binder, indexes, value );
        }

        public override bool TrySetMember( SetMemberBinder binder, object value )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TrySetMember(binder, value))
                {
                    return true;
                }
            }
            if ( TrySetMemberMissing == null )
            {
                return false;
            }
            return TrySetMemberMissing( binder, value );
        }

        public override bool TryUnaryOperation( UnaryOperationBinder binder, out object result )
        {
            if(!ReferenceEquals(Prototype, null))
            {
                if(Prototype.TryUnaryOperation(binder, out result))
                {
                    return true;
                }
            }
            if ( TryUnaryOperationMissing == null )
            {
                result = null;
                return false;
            }
            return TryUnaryOperationMissing( binder, out result );
        }
    }
}
