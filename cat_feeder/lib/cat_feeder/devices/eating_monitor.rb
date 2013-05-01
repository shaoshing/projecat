module CatFeeder
  class EatingMonitor
    MAX_DETECTION_COUNT = 20
    HIT_DETECTION_COUNT = 10
    INTERVAL_MS = 100
    TRIGGER_PIN = 4
    ECHO_PIN = 5

    EATING = 1
    NOT_EATING = 0

    class <<self
      attr_accessor :sonic_sensor

      def run
        Thread.new do
          loop do
            sleep(2) && next if !eating?

            start_eating_at = Time.now

            loop do
              sleep(1) && next if eating?
            end
            end_eating_at = Time.now

            Eating.create(started_at: start_eating_at, ended_at: end_eating_at)
          end
        end
      end

      def eating?
        detections = (0...MAX_DETECTION_COUNT).map{ sleep(INTERVAL_MS/1000.0) && detect }
        eating_count = detections.select{|result| result == EATING}.count
        eating_count >= HIT_DETECTION_COUNT
      end

      def detect
        self.sonic_sensor ||= RaspiModules::SonicSensor.new(TRIGGER_PIN, ECHO_PIN)
        sonic_sensor.detect == 0 ? EATING : NOT_EATING
      end
    end # <<self
  end # EatingMonitor
end # CatFeeder
