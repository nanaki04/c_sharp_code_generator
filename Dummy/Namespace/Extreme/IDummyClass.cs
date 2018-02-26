using System.Collections;
using UniRx;

namespace Dummy.Namespace.Extreme
{
    /// <summary>
    /// defines the interface for dummy classes
    /// </summary>
    public interface IDummyClass
    {
        /// <summary>
        /// a name of something
        /// </summary>
        string Name { get; }

        /// <summary>
        /// gets a value
        /// </summary>
        int GetValue();
    }
}
