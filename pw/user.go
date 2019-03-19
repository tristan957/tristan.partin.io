package pw

// User contains fields that pertain to a user
type User struct {
	Name      *string      `yaml:"name"`
	About     *string      `yaml:"about"`
	ResumeURL *string      `yaml:"resume-url"`
	Jobs      []*Job       `yaml:"jobs"`
	Skills    []*Skill     `yaml:"skills"`
	Schooling []*Education `yaml:"schooling"`
}
