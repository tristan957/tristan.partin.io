package pw

// Job contains fields that pertain to a job
type Job struct {
	Company     *string   `yaml:"company"`
	Title       *string   `yaml:"title"`
	Description *string   `yaml:"description"`
	Tasks       []*string `yaml:"tasks"`
	DateStarted *string   `yaml:"date-started"`
	DateEnded   *string   `yaml:"date-ended"`
}
