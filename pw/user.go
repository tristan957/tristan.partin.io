package pw

// User contains fields that pertain to a user
type User struct {
	Name            *string      `yaml:"name"`
	About           *string      `yaml:"about"`
	ResumeLocation  *string      `yaml:"resume-location"`
	PictureLocation *string      `yaml:"picture-location"`
	Jobs            []*Job       `yaml:"jobs"`
	Skills          []*Skill     `yaml:"skills"`
	Schooling       []*Education `yaml:"schooling"`
}
