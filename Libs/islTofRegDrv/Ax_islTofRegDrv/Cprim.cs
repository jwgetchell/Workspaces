namespace Ax_islTofRegDrv
{
    unsafe public partial class Cprim : Iprim
    {
        // definition
        private readonly Istatus _status;
        private readonly IsamplingControl _samplingControl;
        private readonly IalgorithmControl _algorithmControl;
        private readonly IsignalIntegrity _signalIntegrity;
        private readonly IclosedLoopCalibration _closedLoopCalibration;
        private readonly IopenLoopCorrection _openLoopCorrection;
        private readonly Iinterrupt _interrupt;
        private readonly IdetectionModeControl _detectionModeControl;
        private readonly IanalogControl _analogControl;
        private readonly Idft _dft;
        private readonly Ifuse _fuse;
        private readonly IdigitalTest _digitalTest;
        private readonly IlightSampleStatus _lightSampleStatus;
        private readonly IcalibrationStatus _calibrationStatus;
        private readonly Idebugging _debugging;

        // creation
        public Cprim(Iio _io)
        {
            _status =                new                Cstatus();
            _samplingControl =       new       CsamplingControl();
            _algorithmControl =      new      CalgorithmControl();
            _signalIntegrity =       new       CsignalIntegrity();
            _closedLoopCalibration = new CclosedLoopCalibration();
            _openLoopCorrection =    new    CopenLoopCorrection();
            _interrupt =             new             Cinterrupt();
            _detectionModeControl =  new  CdetectionModeControl();
            _analogControl =         new         CanalogControl();
            _dft =                   new                   Cdft();
            _fuse =                  new                  Cfuse();
            _digitalTest =           new           CdigitalTest();
            _lightSampleStatus =     new     ClightSampleStatus();
            _calibrationStatus =     new  CcalibrationStatus(_io);
            _debugging =             new             Cdebugging();
        }

        // implementation
        public Istatus status { get { return _status; } }
        public IsamplingControl samplingControl { get { return _samplingControl; } }
        public IalgorithmControl algorithmControl { get { return _algorithmControl; } }
        public IsignalIntegrity signalIntegrity { get { return _signalIntegrity; } }
        public IclosedLoopCalibration closedLoopCalibration { get { return _closedLoopCalibration; } }
        public IopenLoopCorrection openLoopCorrection { get { return _openLoopCorrection; } }
        public Iinterrupt interrupt { get { return _interrupt; } }
        public IdetectionModeControl detectionModeControl { get { return _detectionModeControl; } }
        public IanalogControl analogControl { get { return _analogControl; } }
        public Idft dft { get { return _dft; } }
        public Ifuse fuse { get { return _fuse; } }
        public IdigitalTest digitalTest { get { return _digitalTest; } }
        public IlightSampleStatus lightSampleStatus { get { return _lightSampleStatus; } }
        public IcalibrationStatus calibrationStatus { get { return _calibrationStatus; } }
        public Idebugging debugging { get { return _debugging; } }
    }
}
