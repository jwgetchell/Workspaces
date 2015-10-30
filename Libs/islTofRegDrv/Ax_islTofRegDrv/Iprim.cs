namespace Ax_islTofRegDrv
{
    unsafe public partial interface Iprim
    {
        Istatus                               status { get; }
        IsamplingControl             samplingControl { get; }
        IalgorithmControl           algorithmControl { get; }
        IsignalIntegrity             signalIntegrity { get; }
        IclosedLoopCalibration closedLoopCalibration { get; }
        IopenLoopCorrection       openLoopCorrection { get; }
        Iinterrupt                         interrupt { get; }
        IdetectionModeControl   detectionModeControl { get; }
        IanalogControl                 analogControl { get; }
        Idft                                     dft { get; }
        Ifuse                                   fuse { get; }
        IdigitalTest                     digitalTest { get; }
        IlightSampleStatus         lightSampleStatus { get; }
        IcalibrationStatus         calibrationStatus { get; }
        Idebugging                         debugging { get; }
    }
}
